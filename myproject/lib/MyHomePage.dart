import 'package:flutter/material.dart';

import 'data/app_models.dart';
import 'data/app_repository.dart';
import 'pages/create_habit_flow.dart';
import 'pages/insight_general_page.dart';
import 'pages/insight_page.dart';
import 'pages/reflection_page.dart';
import 'pages/settings_pages.dart';
import 'theme/app_design.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _openCreateMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _SheetAction(
                  icon: Icons.edit_calendar_outlined,
                  title: 'Tạo 1 thói quen mới',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateHabitFlowPage(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                _SheetAction(
                  icon: Icons.menu_book_outlined,
                  title: 'Nhật kí hằng ngày',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ReflectionPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    Container(
                      width: 72,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.28),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.card_giftcard,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SettingsPage()),
                      ),
                      icon: const Icon(
                        Icons.tune,
                        color: Colors.white,
                        size: 27,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _LiveStreakCard(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StreakInfoPage()),
                  ),
                ),
                const SizedBox(height: 30),
                const _HabitSections(),
              ],
            ),
          ),
          AppBottomNav(
            index: 0,
            onHome: () {},
            onInsight: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InsightGeneralPage()),
            ),
            onCreate: () => _openCreateMenu(context),
            onReflection: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReflectionPage()),
            ),
            onCommunity: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InsightPage()),
            ),
          ),
        ],
      ),
    );
  }
}

class _HabitSections extends StatelessWidget {
  const _HabitSections();

  @override
  Widget build(BuildContext context) {
    if (!AppRepository.isFirebaseReady) {
      return const _FallbackHabitSections();
    }

    return StreamBuilder<List<HabitRecord>>(
      stream: AppRepository().watchHabits(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Column(
            children: [
              const _FallbackHabitSections(),
              const SizedBox(height: 12),
              Text(
                'Không thể đọc Firestore: ${snapshot.error}',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(color: AppColors.mint),
            ),
          );
        }

        final habits = snapshot.data!;
        if (habits.isEmpty) {
          return GlassCard(
            child: const Text(
              'Chưa có thói quen. Nhấn dấu + để tạo thói quen đầu tiên.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return StreamBuilder<List<HabitLog>>(
          stream: AppRepository().watchLogs(),
          builder: (context, logSnapshot) {
            final logs = logSnapshot.data ?? const <HabitLog>[];
            final today = AppRepository.dateKey(DateTime.now());
            final completedIds = logs
                .where((log) => log.completed && log.dateKey == today)
                .map((log) => log.habitId)
                .toSet();
            final pending = habits
                .where((habit) => !completedIds.contains(habit.id))
                .toList();
            final completed = habits
                .where((habit) => completedIds.contains(habit.id))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Ngày hôm nay'),
                const SizedBox(height: 10),
                ...pending.map(
                  (habit) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _FirestoreTaskCard(habit: habit, completed: false),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const _SectionTitle('Nhiệm vụ hoàn thành'),
                    const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white.withOpacity(.85),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...completed.map(
                  (habit) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _FirestoreTaskCard(habit: habit, completed: true),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _FirestoreTaskCard extends StatelessWidget {
  const _FirestoreTaskCard({required this.habit, required this.completed});

  final HabitRecord habit;
  final bool completed;

  @override
  Widget build(BuildContext context) {
    return _TaskCard(
      time: habit.reminderTime.isEmpty ? '--:--' : habit.reminderTime,
      title: habit.name,
      icon: habit.area.contains('Tâm')
          ? Icons.psychology_alt
          : Icons.track_changes,
      active: !completed,
      onTap: () async {
        await AppRepository().toggleHabitForToday(habit, !completed);
      },
    );
  }
}

class _FallbackHabitSections extends StatelessWidget {
  const _FallbackHabitSections();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('Ngày hôm nay'),
        const SizedBox(height: 10),
        _TaskCard(
          time: '08:40',
          title: 'Học Tiếng Anh',
          icon: Icons.psychology_alt,
          active: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditHabitPage()),
          ),
        ),
        const SizedBox(height: 28),
        Row(
          children: [
            const _SectionTitle('Nhiệm vụ hoàn thành'),
            const Spacer(),
            Icon(Icons.keyboard_arrow_up, color: Colors.white.withOpacity(.85)),
          ],
        ),
        const SizedBox(height: 10),
        _TaskCard(
          time: '08:40',
          title: 'Học Tiếng Anh',
          icon: Icons.fitness_center,
          active: false,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditHabitPage()),
          ),
        ),
      ],
    );
  }
}

class _SheetAction extends StatelessWidget {
  const _SheetAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      leading: Container(
        width: 66,
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, color: AppColors.violetDark, size: 30),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Color(0xFF282828)),
      ),
      onTap: onTap,
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({
    required this.onTap,
    required this.streak,
    required this.streakDates,
  });

  final VoidCallback onTap;
  final int streak;
  final List<DateTime> streakDates;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 12,
      padding: const EdgeInsets.fromLTRB(13, 16, 16, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$streak ngày liên tiếp',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 52,
                  child: streakDates.isEmpty
                      ? const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Chưa có ngày hoàn thành',
                            style: TextStyle(color: Colors.white70),
                          ),
                        )
                      : ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: streakDates.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 16),
                          itemBuilder: (context, index) =>
                              _DayDot(date: streakDates[index]),
                        ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Làm tốt lắm!',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 56,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LiveStreakCard extends StatelessWidget {
  const _LiveStreakCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!AppRepository.isFirebaseReady) {
      final today = DateTime.now();
      return _StreakCard(
        onTap: onTap,
        streak: 2,
        streakDates: [today.subtract(const Duration(days: 1)), today],
      );
    }
    return StreamBuilder<List<HabitLog>>(
      stream: AppRepository().watchLogs(),
      builder: (context, snapshot) {
        final logs = snapshot.data ?? const <HabitLog>[];
        final stats = AppRepository.calculateStatistics(
          logs,
          const <ReflectionRecord>[],
        );
        return _StreakCard(
          onTap: onTap,
          streak: stats.currentStreak,
          streakDates: AppRepository.currentStreakDates(logs),
        );
      },
    );
  }
}

class StreakInfoPage extends StatelessWidget {
  const StreakInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'May 30, 2024',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GlassCard(
              radius: 9,
              color: const Color(0xFFEEDCFF),
              child: Row(
                children: const [
                  _DayDot(day: 'Thứ Hai'),
                  SizedBox(width: 24),
                  _DayDot(day: 'Thứ Ba'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              radius: 12,
              color: AppColors.violet.withOpacity(.82),
              child: const Text(
                'Bằng cách vượt qua những vấn đề của chính mình để quan tâm đến người khác, bạn sẽ có được sức mạnh nội tâm, sự tự tin, lòng can đảm và một cảm giác bình an lớn lao hơn\n\n~ Dalai Lama',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  height: 1.45,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GlassCard(
              radius: 12,
              color: const Color(0xFF251B72).withOpacity(.86),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bạn cảm nhận như thế nào',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '1\n😞',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        '2\n😟',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        '3\n🙂',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        '4\n😃',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Text(
                        '5\n😌',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'Đã Hiểu',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({this.date, this.day});

  final DateTime? date;
  final String? day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: AppColors.mint, size: 27),
        const SizedBox(height: 5),
        Text(
          day ?? _weekdayLabel(date!.weekday),
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ],
    );
  }

  String _weekdayLabel(int weekday) => switch (weekday) {
    DateTime.monday => 'T2',
    DateTime.tuesday => 'T3',
    DateTime.wednesday => 'T4',
    DateTime.thursday => 'T5',
    DateTime.friday => 'T6',
    DateTime.saturday => 'T7',
    _ => 'CN',
  };
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w800,
        fontSize: 15,
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.time,
    required this.title,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String time;
  final String title;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        radius: 12,
        color: active
            ? Colors.white.withOpacity(.32)
            : const Color(0xFF27117E).withOpacity(.88),
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 16),
        child: SizedBox(
          height: 82,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: active ? Colors.white : const Color(0xFFFFEB54),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: List.generate(
                      5,
                      (i) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(
                          color: i == 3
                              ? Colors.white.withOpacity(.7)
                              : AppColors.mint,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    icon,
                    color: active
                        ? const Color(0xFF9F91FF)
                        : const Color(0xFFE2D6FF),
                    size: 34,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: TextStyle(
                      color: active ? Colors.white : AppColors.violet,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
