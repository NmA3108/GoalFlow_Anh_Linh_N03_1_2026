import 'package:cloud_firestore/cloud_firestore.dart';

DateTime? _dateFrom(dynamic value) =>
    value is Timestamp ? value.toDate() : null;

class AppUser {
  const AppUser({
    required this.id,
    required this.displayName,
    required this.email,
    this.createdAt,
  });

  final String id;
  final String displayName;
  final String email;
  final DateTime? createdAt;

  factory AppUser.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return AppUser(
      id: document.id,
      displayName: data['displayName'] as String? ?? '',
      email: data['email'] as String? ?? '',
      createdAt: _dateFrom(data['createdAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'displayName': displayName,
    'email': email,
    'createdAt': FieldValue.serverTimestamp(),
  };
}

class HabitRecord {
  const HabitRecord({
    required this.id,
    required this.name,
    required this.area,
    required this.days,
    required this.reason,
    required this.reminderEnabled,
    required this.reminderTime,
    required this.active,
    this.createdAt,
  });

  final String id;
  final String name;
  final String area;
  final List<String> days;
  final String reason;
  final bool reminderEnabled;
  final String reminderTime;
  final bool active;
  final DateTime? createdAt;

  factory HabitRecord.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return HabitRecord(
      id: document.id,
      name: data['name'] as String? ?? '',
      area: data['area'] as String? ?? '',
      days: List<String>.from(data['days'] as List? ?? const []),
      reason: data['reason'] as String? ?? '',
      reminderEnabled: data['reminderEnabled'] as bool? ?? false,
      reminderTime: data['reminderTime'] as String? ?? '',
      active: data['active'] as bool? ?? true,
      createdAt: _dateFrom(data['createdAt']),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'name': name,
    'area': area,
    'days': days,
    'reason': reason,
    'reminderEnabled': reminderEnabled,
    'reminderTime': reminderTime,
    'active': active,
    'createdAt': FieldValue.serverTimestamp(),
  };
}

class HabitLog {
  const HabitLog({
    required this.id,
    required this.habitId,
    required this.dateKey,
    required this.completed,
    required this.minutes,
    this.completedAt,
  });

  final String id;
  final String habitId;
  final String dateKey;
  final bool completed;
  final int minutes;
  final DateTime? completedAt;

  factory HabitLog.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return HabitLog(
      id: document.id,
      habitId: data['habitId'] as String? ?? '',
      dateKey: data['dateKey'] as String? ?? '',
      completed: data['completed'] as bool? ?? false,
      minutes: (data['minutes'] as num?)?.toInt() ?? 0,
      completedAt: _dateFrom(data['completedAt']),
    );
  }
}

class ReflectionRecord {
  const ReflectionRecord({
    required this.id,
    required this.dateKey,
    required this.moodScore,
    required this.emotions,
    required this.activities,
    required this.note,
    this.createdAt,
  });

  final String id;
  final String dateKey;
  final int moodScore;
  final List<String> emotions;
  final List<String> activities;
  final String note;
  final DateTime? createdAt;

  factory ReflectionRecord.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return ReflectionRecord(
      id: document.id,
      dateKey: data['dateKey'] as String? ?? '',
      moodScore: (data['moodScore'] as num?)?.toInt() ?? 3,
      emotions: List<String>.from(data['emotions'] as List? ?? const []),
      activities: List<String>.from(data['activities'] as List? ?? const []),
      note: data['note'] as String? ?? '',
      createdAt: _dateFrom(data['createdAt']),
    );
  }
}

class HealingContent {
  const HealingContent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.author,
    required this.url,
    required this.imageUrl,
    required this.order,
  });

  final String id;
  final String title;
  final String subtitle;
  final String type;
  final String author;
  final String url;
  final String imageUrl;
  final int order;

  factory HealingContent.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? const <String, dynamic>{};
    return HealingContent(
      id: document.id,
      title: data['title'] as String? ?? '',
      subtitle: data['subtitle'] as String? ?? '',
      type: data['type'] as String? ?? 'book',
      author: data['author'] as String? ?? '',
      url: data['url'] as String? ?? '',
      imageUrl: data['imageUrl'] as String? ?? '',
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }
}

class HabitStatistics {
  const HabitStatistics({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalMinutes,
    required this.weeklyCompleted,
    required this.averageMood,
  });

  final int currentStreak;
  final int longestStreak;
  final int totalMinutes;
  final List<int> weeklyCompleted;
  final double averageMood;
}
