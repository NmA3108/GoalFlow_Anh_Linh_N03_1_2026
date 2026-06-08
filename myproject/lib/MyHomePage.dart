import 'package:flutter/material.dart';

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
                _StreakCard(),
                const SizedBox(height: 30),
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
                    Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white.withOpacity(.85),
                    ),
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
                const Text(
                  '2 ngày liên tiếp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  children: const [
                    _DayDot(day: 'T2'),
                    SizedBox(width: 16),
                    _DayDot(day: 'T3'),
                  ],
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
              Container(
                width: 56,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.violet,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DayDot extends StatelessWidget {
  const _DayDot({required this.day});

  final String day;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: AppColors.mint, size: 27),
        const SizedBox(height: 5),
        Text(day, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }
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
