import 'package:flutter_test/flutter_test.dart';
import 'package:myproject/data/app_models.dart';
import 'package:myproject/data/app_repository.dart';

void main() {
  test(
    'calculates streak, minutes, weekly data and average mood from records',
    () {
      final now = DateTime.now();
      final logs = [
        for (var offset = 1; offset <= 2; offset++)
          HabitLog(
            id: 'log-$offset',
            habitId: 'habit-1',
            dateKey: AppRepository.dateKey(
              now.subtract(Duration(days: offset)),
            ),
            completed: true,
            minutes: 20,
          ),
      ];
      const reflections = [
        ReflectionRecord(
          id: 'reflection-1',
          dateKey: '2026-06-08',
          moodScore: 4,
          emotions: ['Biết ơn'],
          activities: ['Học'],
          note: 'Một ngày tốt.',
        ),
        ReflectionRecord(
          id: 'reflection-2',
          dateKey: '2026-06-09',
          moodScore: 5,
          emotions: ['Bình yên'],
          activities: ['Bạn bè'],
          note: 'Hoàn thành mục tiêu.',
        ),
      ];

      final statistics = AppRepository.calculateStatistics(logs, reflections);
      final weekStart = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: now.weekday - 1));
      final expectedWeeklyCount = logs.where((log) {
        final date = DateTime.parse(log.dateKey);
        return !date.isBefore(weekStart);
      }).length;

      expect(statistics.currentStreak, 2);
      expect(statistics.longestStreak, 2);
      expect(statistics.totalMinutes, 40);
      expect(
        statistics.weeklyCompleted.reduce((a, b) => a + b),
        expectedWeeklyCount,
      );
      expect(statistics.averageMood, 4.5);
      final streakDates = AppRepository.currentStreakDates(logs);
      expect(streakDates, hasLength(2));
      expect(
        AppRepository.dateKey(streakDates.last),
        AppRepository.dateKey(now.subtract(const Duration(days: 1))),
      );
    },
  );
}
