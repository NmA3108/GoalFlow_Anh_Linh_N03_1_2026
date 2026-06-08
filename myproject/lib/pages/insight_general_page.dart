import 'package:flutter/material.dart';

import '../theme/app_design.dart';
import 'create_habit_flow.dart';
import 'insight_page.dart';
import 'reflection_page.dart';
import 'settings_pages.dart';

class InsightGeneralPage extends StatefulWidget {
  const InsightGeneralPage({super.key});

  @override
  State<InsightGeneralPage> createState() => _InsightGeneralPageState();
}

class _InsightGeneralPageState extends State<InsightGeneralPage> {
  bool _individual = false;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
              physics: const BouncingScrollPhysics(),
              children: [
                Text(
                  _individual ? 'Phân tích' : 'Thống kê',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 18),
                _SegmentedTabs(
                  individual: _individual,
                  onGeneral: () => setState(() => _individual = false),
                  onIndividual: () => setState(() => _individual = true),
                ),
                const SizedBox(height: 22),
                _individual ? const _IndividualStats() : const _GeneralStats(),
              ],
            ),
          ),
          AppBottomNav(
            index: 1,
            onHome: () => Navigator.pop(context),
            onInsight: () {},
            onCreate: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateHabitFlowPage()),
            ),
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

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.individual,
    required this.onGeneral,
    required this.onIndividual,
  });

  final bool individual;
  final VoidCallback onGeneral;
  final VoidCallback onIndividual;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF070653).withOpacity(.72),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withOpacity(.08)),
      ),
      child: Row(
        children: [
          _TabButton(label: 'Tổng quan', active: !individual, onTap: onGeneral),
          _TabButton(label: 'Cá nhân', active: individual, onTap: onIndividual),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active
                ? const Color(0xFF2C35BF).withOpacity(.72)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? Colors.white : Colors.white.withOpacity(.43),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}

class _GeneralStats extends StatelessWidget {
  const _GeneralStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _HabitOverviewCard(),
        SizedBox(height: 20),
        _PremiumStatsCard(),
      ],
    );
  }
}

class _HabitOverviewCard extends StatelessWidget {
  const _HabitOverviewCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 12,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Thói quen đã hoàn thành',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Spacer(),
              Text(
                'Tuần',
                style: TextStyle(
                  color: AppColors.mint,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(7, (i) {
              final shades = [
                const Color(0xFFD8BFFF),
                const Color(0xFFB88CFB),
                const Color(0xFF9B6FF0),
                const Color(0xFF7454CD),
                const Color(0xFF4B2E91),
              ];
              return Expanded(
                child: Container(
                  height: 46,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: shades[i % shades.length],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    i == 0 ? '0' : '1',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Ít hơn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                'Nhiều hơn',
                style: TextStyle(
                  color: Colors.white.withOpacity(.9),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'TÂM TRẠNG HÀNG NGÀY',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 14),
          Row(
            children: List.generate(
              7,
              (i) => Expanded(
                child: Container(
                  height: 46,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7D5FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Tồi tệ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              ...[
                Colors.red,
                Colors.deepOrange,
                Colors.amber,
                Colors.purpleAccent,
                AppColors.violet,
              ].map(
                (color) => Expanded(
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Tốt hơn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PremiumStatsCard extends StatelessWidget {
  const _PremiumStatsCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 12,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
      child: Column(
        children: [
          const Text(
            'Mở khóa bản Premium để xem\nthêm thống kê',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.25,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 28),
          const Icon(
            Icons.workspace_premium,
            color: Color(0xFFC0B4FF),
            size: 80,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PricePage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.violet,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Tiếp tục',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IndividualStats extends StatelessWidget {
  const _IndividualStats();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Luyện nghe tiếng Anh',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 26),
        _StreakSummary(),
        SizedBox(height: 20),
        _TrackingHint(),
        SizedBox(height: 20),
        _CalendarCard(),
        SizedBox(height: 16),
        _InfoCard(
          title: 'Bạn theo dõi thói quen này vào:',
          body:
              'Thứ Ba    Thứ Năm    Thứ Bảy\n\nKhông làm vào ngày mở không mất chuỗi.\nKhông ảnh hưởng đến chuỗi của bạn.',
        ),
        SizedBox(height: 16),
        _InfoCard(
          title: 'Thời gian đã dành',
          body: 'Bạn đã dành 120 phút\ncho thói quen này',
        ),
        SizedBox(height: 16),
        _InfoCard(
          title: 'Chuỗi dài nhất',
          body: 'Chuỗi dài nhất của bạn là 10 ngày',
        ),
      ],
    );
  }
}

class _StreakSummary extends StatelessWidget {
  const _StreakSummary();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 8,
      child: Row(
        children: const [
          Text(
            '10',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 18),
          Text(
            'Chuỗi ngày',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _TrackingHint extends StatelessWidget {
  const _TrackingHint();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 8,
      child: const Text(
        'Theo dõi thói quen này và tâm trạng của bạn trong tổng 10 ngày để xem kết quả.',
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
          height: 1.18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _CalendarCard extends StatelessWidget {
  const _CalendarCard();

  @override
  Widget build(BuildContext context) {
    final done = {1, 2, 4, 15, 17, 18, 21, 23, 24, 25};
    return GlassCard(
      radius: 8,
      color: const Color(0xFF160D68).withOpacity(.78),
      child: Column(
        children: [
          Row(
            children: const [
              Text(
                'Tháng 3',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(),
              _YearButton(),
            ],
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: List.generate(31, (i) {
              final day = i + 1;
              final today = day == 26;
              final isDone = done.contains(day);
              return Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: today
                      ? Colors.white
                      : isDone
                      ? AppColors.mint
                      : const Color(0xFFC7A6FF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$day',
                  style: TextStyle(
                    color: today || isDone
                        ? Colors.black
                        : const Color(0xFF604C96),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              _Legend(color: AppColors.mint, label: 'Hoàn thành'),
              SizedBox(width: 20),
              _Legend(color: Colors.white, label: 'Hôm nay'),
            ],
          ),
        ],
      ),
    );
  }
}

class _YearButton extends StatelessWidget {
  const _YearButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Xem theo năm',
        style: TextStyle(color: Color(0xFF21102E), fontWeight: FontWeight.w900),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            body,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
