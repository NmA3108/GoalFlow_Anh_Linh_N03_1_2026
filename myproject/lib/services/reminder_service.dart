import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderService {
  ReminderService._();

  static final ReminderService instance = ReminderService._();
  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final Map<int, Timer> _webTimers = {};
  bool _initialized = false;

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'habit_reminders',
      'Nhắc nhở thói quen',
      channelDescription: 'Thông báo khi đến giờ thực hiện thói quen',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezone.identifier));
    } on Exception {
      tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
    }

    await _notifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );
    _initialized = true;
  }

  Future<bool> requestPermission() async {
    try {
      await initialize();
    } catch (error) {
      debugPrint('Không thể khởi tạo thông báo: $error');
      return false;
    }

    if (kIsWeb) {
      final web = _notifications
          .resolvePlatformSpecificImplementation<
            WebFlutterLocalNotificationsPlugin
          >();
      if (web == null) return false;
      if (web.permissionStatus == WebNotificationPermission.granted) {
        return true;
      }
      return await web.requestNotificationsPermission() ?? false;
    }

    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      final notificationsAllowed =
          await android.requestNotificationsPermission() ?? false;
      final exactAlarmsAllowed =
          await android.requestExactAlarmsPermission() ?? false;
      return notificationsAllowed && exactAlarmsAllowed;
    }

    final ios = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    return await ios?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        true;
  }

  Future<void> scheduleHabit({
    required String habitId,
    required String habitName,
    required List<String> days,
    required String time,
  }) async {
    await initialize();
    await cancelHabit(habitId);

    final parts = time.split(':');
    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;

    final daily = days.contains('Mỗi ngày') || days.isEmpty;
    final weekdays = daily ? [DateTime.now().weekday] : _weekdaysFor(days);
    if (kIsWeb) {
      for (var index = 0; index < weekdays.length; index++) {
        _scheduleWebTimer(
          id: _notificationId(habitId, index),
          habitName: habitName,
          weekday: weekdays[index],
          hour: hour,
          minute: minute,
          daily: daily,
        );
      }
      return;
    }

    for (var index = 0; index < weekdays.length; index++) {
      final weekday = weekdays[index];
      final scheduled = daily
          ? _nextDailyTime(hour, minute)
          : _nextDate(weekday, hour, minute);
      await _notifications.zonedSchedule(
        id: _notificationId(habitId, index),
        title: 'Đến giờ thực hiện thói quen',
        body: habitName,
        scheduledDate: scheduled,
        notificationDetails: _details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: daily
            ? DateTimeComponents.time
            : DateTimeComponents.dayOfWeekAndTime,
        payload: habitId,
      );
    }
  }

  Future<void> cancelHabit(String habitId) async {
    for (var index = 0; index < 7; index++) {
      final id = _notificationId(habitId, index);
      _webTimers.remove(id)?.cancel();
      await _notifications.cancel(id: id);
    }
  }

  void _scheduleWebTimer({
    required int id,
    required String habitName,
    required int weekday,
    required int hour,
    required int minute,
    required bool daily,
  }) {
    final scheduled = daily
        ? _nextDailyTime(hour, minute)
        : _nextDate(weekday, hour, minute);
    _webTimers[id] = Timer(
      scheduled.difference(tz.TZDateTime.now(tz.local)),
      () {
        _notifications.show(
          id: id,
          title: 'Đến giờ thực hiện thói quen',
          body: habitName,
          notificationDetails: _details,
        );
        _scheduleWebTimer(
          id: id,
          habitName: habitName,
          weekday: weekday,
          hour: hour,
          minute: minute,
          daily: daily,
        );
      },
    );
  }

  tz.TZDateTime _nextDate(int weekday, int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    while (!scheduled.isAfter(now) || scheduled.weekday != weekday) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  tz.TZDateTime _nextDailyTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }

  List<int> _weekdaysFor(List<String> days) {
    const values = {
      'Thứ Hai': DateTime.monday,
      'Thứ Ba': DateTime.tuesday,
      'Thứ Tư': DateTime.wednesday,
      'Thứ Năm': DateTime.thursday,
      'Thứ Sáu': DateTime.friday,
      'Thứ Bảy': DateTime.saturday,
      'Chủ Nhật': DateTime.sunday,
    };
    return days.map((day) => values[day]).whereType<int>().toList();
  }

  int _notificationId(String habitId, int index) {
    var hash = 2166136261;
    for (final unit in habitId.codeUnits) {
      hash = (hash ^ unit) * 16777619;
    }
    return ((hash & 0x7fffffff) % 200000000) * 10 + index;
  }
}
