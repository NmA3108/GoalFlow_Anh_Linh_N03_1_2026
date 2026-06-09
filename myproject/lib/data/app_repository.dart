import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app_models.dart';

class AppRepository {
  AppRepository({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const demoUserId = 'demo-user';
  final FirebaseFirestore _firestore;

  static bool get isFirebaseReady => Firebase.apps.isNotEmpty;

  DocumentReference<Map<String, dynamic>> get _user =>
      _firestore.collection('users').doc(demoUserId);
  CollectionReference<Map<String, dynamic>> get _habits =>
      _user.collection('habits');
  CollectionReference<Map<String, dynamic>> get _logs =>
      _user.collection('habitLogs');
  CollectionReference<Map<String, dynamic>> get _reflections =>
      _user.collection('reflections');
  CollectionReference<Map<String, dynamic>> get _contents =>
      _firestore.collection('healingContents');

  static String dateKey(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  Stream<AppUser> watchUser() => _user.snapshots().map(AppUser.fromDocument);

  Stream<List<HabitRecord>> watchHabits() =>
      _habits.where('active', isEqualTo: true).snapshots().map((snapshot) {
        final items = snapshot.docs.map(HabitRecord.fromDocument).toList();
        items.sort(
          (a, b) => (b.createdAt ?? DateTime(1970)).compareTo(
            a.createdAt ?? DateTime(1970),
          ),
        );
        return items;
      });

  Stream<List<HabitLog>> watchLogs() => _logs.snapshots().map(
    (snapshot) => snapshot.docs.map(HabitLog.fromDocument).toList(),
  );

  Stream<List<ReflectionRecord>> watchReflections() =>
      _reflections.snapshots().map(
        (snapshot) => snapshot.docs.map(ReflectionRecord.fromDocument).toList(),
      );

  Stream<List<HealingContent>> watchHealingContents() => _contents
      .orderBy('order')
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(HealingContent.fromDocument).toList(),
      );

  Future<String> createHabit({
    required String name,
    required String area,
    required List<String> days,
    required String reason,
    required bool reminderEnabled,
    required String reminderTime,
  }) async {
    final document = await _habits.add(
      HabitRecord(
        id: '',
        name: name,
        area: area,
        days: days,
        reason: reason,
        reminderEnabled: reminderEnabled,
        reminderTime: reminderTime,
        active: true,
      ).toFirestore(),
    );
    return document.id;
  }

  Future<void> updateHabitReminder({
    required String habitId,
    required bool enabled,
    required String time,
  }) {
    return _habits.doc(habitId).update({
      'reminderEnabled': enabled,
      'reminderTime': enabled ? time : '',
    });
  }

  Future<void> toggleHabitForToday(HabitRecord habit, bool completed) {
    final today = dateKey(DateTime.now());
    return _logs.doc('${today}_${habit.id}').set({
      'habitId': habit.id,
      'dateKey': today,
      'completed': completed,
      'minutes': completed ? 20 : 0,
      'completedAt': completed ? FieldValue.serverTimestamp() : null,
    }, SetOptions(merge: true));
  }

  Future<void> saveReflection({
    required int moodScore,
    required List<String> emotions,
    required List<String> activities,
    required String note,
  }) {
    final today = dateKey(DateTime.now());
    return _reflections.doc(today).set({
      'dateKey': today,
      'moodScore': moodScore,
      'emotions': emotions,
      'activities': activities,
      'note': note,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> ensureSeedData() async {
    final userSnapshot = await _user.get();
    if (!userSnapshot.exists) {
      await _user.set(
        const AppUser(
          id: demoUserId,
          displayName: 'Mai Ngọc Linh',
          email: 'maingoclinh412005@gmail.com',
        ).toFirestore(),
      );
    }

    final habitSnapshot = await _habits.limit(1).get();
    if (habitSnapshot.docs.isEmpty) {
      final habit = _habits.doc();
      final batch = _firestore.batch();
      batch.set(
        habit,
        HabitRecord(
          id: habit.id,
          name: 'Học Tiếng Anh',
          area: 'Tâm trí',
          days: const ['Thứ Ba', 'Thứ Năm', 'Thứ Bảy'],
          reason: 'Cải thiện khả năng nghe tiếng Anh',
          reminderEnabled: true,
          reminderTime: '08:40',
          active: true,
        ).toFirestore(),
      );

      final now = DateTime.now();
      for (var offset = 1; offset <= 2; offset++) {
        final date = now.subtract(Duration(days: offset));
        final key = dateKey(date);
        batch.set(_logs.doc('${key}_${habit.id}'), {
          'habitId': habit.id,
          'dateKey': key,
          'completed': true,
          'minutes': 20,
          'completedAt': Timestamp.fromDate(date),
        });
      }
      await batch.commit();
    }

    final reflectionSnapshot = await _reflections.limit(1).get();
    if (reflectionSnapshot.docs.isEmpty) {
      final now = DateTime.now();
      for (var offset = 0; offset < 5; offset++) {
        final date = now.subtract(Duration(days: offset));
        final key = dateKey(date);
        await _reflections.doc(key).set({
          'dateKey': key,
          'moodScore': 3 + (offset % 3),
          'emotions': ['Biết ơn', offset.isEven ? 'Bình yên' : 'Hưng phấn'],
          'activities': ['Học', 'Bạn bè'],
          'note': offset == 0
              ? 'Hôm nay mình đã hoàn thành mục tiêu học tập.'
              : 'Một ngày đáng để nhìn lại.',
          'createdAt': Timestamp.fromDate(date),
        });
      }
    }

    final contentSnapshot = await _contents.limit(1).get();
    if (contentSnapshot.docs.isEmpty) {
      final batch = _firestore.batch();
      final items = [
        {
          'title': 'Thói quen nhỏ',
          'subtitle': 'Atomic Habits - thay đổi nhỏ tạo kết quả lớn',
          'type': 'book',
          'author': 'James Clear',
          'url': 'https://jamesclear.com/atomic-habits',
          'imageUrl': '',
          'order': 1,
        },
        {
          'title': 'Chữa lành từ bên trong',
          'subtitle': 'Podcast về bình an và chăm sóc sức khỏe tinh thần',
          'type': 'podcast',
          'author': 'GoalFlow Podcast',
          'url': 'https://open.spotify.com/',
          'imageUrl': '',
          'order': 2,
        },
        {
          'title': 'Sức mạnh của hiện tại',
          'subtitle': 'Tìm lại sự bình yên trong từng khoảnh khắc',
          'type': 'book',
          'author': 'Eckhart Tolle',
          'url': 'https://eckharttolle.com/',
          'imageUrl': '',
          'order': 3,
        },
      ];
      for (final item in items) {
        batch.set(_contents.doc(), item);
      }
      await batch.commit();
    }
  }

  static HabitStatistics calculateStatistics(
    List<HabitLog> logs,
    List<ReflectionRecord> reflections,
  ) {
    final completedDates = logs
        .where((log) => log.completed)
        .map((log) => log.dateKey)
        .toSet();
    final today = DateTime.now();

    var currentStreak = 0;
    for (var offset = 0; ; offset++) {
      final key = dateKey(today.subtract(Duration(days: offset)));
      if (!completedDates.contains(key)) break;
      currentStreak++;
    }
    if (currentStreak == 0) {
      for (var offset = 1; ; offset++) {
        final key = dateKey(today.subtract(Duration(days: offset)));
        if (!completedDates.contains(key)) break;
        currentStreak++;
      }
    }

    final sortedDates = completedDates.toList()..sort();
    var longest = 0;
    var running = 0;
    DateTime? previous;
    for (final key in sortedDates) {
      final date = DateTime.parse(key);
      if (previous != null && date.difference(previous).inDays == 1) {
        running++;
      } else {
        running = 1;
      }
      if (running > longest) longest = running;
      previous = date;
    }

    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    final weekly = List<int>.generate(7, (index) {
      final key = dateKey(startOfWeek.add(Duration(days: index)));
      return logs.where((log) => log.completed && log.dateKey == key).length;
    });
    final totalMinutes = logs
        .where((log) => log.completed)
        .fold<int>(0, (sum, log) => sum + log.minutes);
    final averageMood = reflections.isEmpty
        ? 0.0
        : reflections.fold<int>(0, (sum, item) => sum + item.moodScore) /
              reflections.length;

    return HabitStatistics(
      currentStreak: currentStreak,
      longestStreak: longest,
      totalMinutes: totalMinutes,
      weeklyCompleted: weekly,
      averageMood: averageMood,
    );
  }

  static List<DateTime> currentStreakDates(List<HabitLog> logs) {
    final completedDates = logs
        .where((log) => log.completed)
        .map((log) => log.dateKey)
        .toSet();
    if (completedDates.isEmpty) return const [];

    final now = DateTime.now();
    var cursor = DateTime(now.year, now.month, now.day);
    if (!completedDates.contains(dateKey(cursor))) {
      cursor = cursor.subtract(const Duration(days: 1));
    }

    final dates = <DateTime>[];
    while (completedDates.contains(dateKey(cursor))) {
      dates.add(cursor);
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return dates.reversed.toList();
  }
}
