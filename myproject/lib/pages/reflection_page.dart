import 'package:flutter/material.dart';

import '../theme/app_design.dart';
import 'create_habit_flow.dart';
import 'insight_general_page.dart';
import 'insight_page.dart';

class ReflectionPage extends StatefulWidget {
  const ReflectionPage({super.key});

  @override
  State<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends State<ReflectionPage> {
  int _page = 0;
  final Set<String> _emotions = {'Mơ hồ', 'Hạnh phúc', 'Biết ơn'};
  final Set<String> _activities = {'Tình yêu', 'Học', 'Việc nhà'};
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          Expanded(child: _buildContent()),
          if (_page != 3)
            _BottomActions(
              showNav: _page == 0,
              onBack: () {
                if (_page == 0) {
                  Navigator.pop(context);
                } else {
                  setState(() => _page--);
                }
              },
              onNext: () => setState(() => _page = (_page + 1).clamp(0, 3)),
            ),
          if (_page == 0)
            AppBottomNav(
              index: 3,
              onHome: () => Navigator.pop(context),
              onInsight: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InsightGeneralPage()),
              ),
              onCreate: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateHabitFlowPage()),
              ),
              onReflection: () {},
              onCommunity: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const InsightPage()),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_page) {
      case 0:
        return _ReviewPage(onStart: () => setState(() => _page = 1));
      case 1:
        return _EmotionPage(selected: _emotions, onToggle: _toggleEmotion);
      case 2:
        return _ActivityPage(selected: _activities, onToggle: _toggleActivity);
      default:
        return _NotePage(
          controller: _noteController,
          onDone: () => Navigator.pop(context),
        );
    }
  }

  void _toggleEmotion(String value) {
    setState(
      () => _emotions.contains(value)
          ? _emotions.remove(value)
          : _emotions.add(value),
    );
  }

  void _toggleActivity(String value) {
    setState(
      () => _activities.contains(value)
          ? _activities.remove(value)
          : _activities.add(value),
    );
  }
}

class _ReviewPage extends StatelessWidget {
  const _ReviewPage({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
      physics: const BouncingScrollPhysics(),
      children: [
        const Text(
          'Nhìn lại',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 76,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final faces = ['😞', '😟', '🙂', '+', '+', '😄', '+'];
              return Column(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.violet.withOpacity(.78),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      faces[index],
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'May  ${24 + index}',
                    style: const TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 45,
          child: ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.violet,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Nhấn để nhìn lại ngày của bạn',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        ),
        const SizedBox(height: 22),
        GlassCard(
          radius: 12,
          color: const Color(0xFF20147A).withOpacity(.86),
          child: Row(
            children: const [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tâm trạng của bạn vào 28-04-2025',
                      style: TextStyle(color: Color(0xFFBDB4E7)),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Tuyệt vời',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '3',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(width: 22),
              CircleAvatar(
                radius: 28,
                backgroundColor: Color(0xFFFF4267),
                child: Icon(Icons.favorite, color: Colors.white, size: 34),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          radius: 12,
          color: const Color(0xFFD7CCF0).withOpacity(.78),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Suy nghĩ của bạn',
                style: TextStyle(
                  color: Color(0xFF433360),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Tôi không biết',
                style: TextStyle(color: Color(0xFF211C35), fontSize: 17),
              ),
              SizedBox(height: 18),
              Text(
                'Cảm xúc của bạn',
                style: TextStyle(
                  color: Color(0xFF433360),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              _TagRow(tags: ['Tự hào', 'Hưng phấn', 'Bất ổn', 'Biết ơn']),
              SizedBox(height: 18),
              Text(
                'Hoạt động của bạn',
                style: TextStyle(
                  color: Color(0xFF433360),
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _ActivityMini(icon: '😡', label: 'Thể thao'),
                  _ActivityMini(icon: '😡', label: 'Tình yêu'),
                  _ActivityMini(icon: '😡', label: 'Bạn bè'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          radius: 12,
          color: const Color(0xFF251B72).withOpacity(.82),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Tuần của bạn',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 14),
              _WeekBars(),
            ],
          ),
        ),
        const SizedBox(height: 16),
        GlassCard(
          radius: 12,
          color: AppColors.violet.withOpacity(.82),
          child: Row(
            children: const [
              Text(
                'Tâm trạng trung bình\nKhá vui vẻ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.55,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Spacer(),
              Text(
                '4.0',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EmotionPage extends StatelessWidget {
  const _EmotionPage({required this.selected, required this.onToggle});

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final items = [
      'Tự hào',
      'Mơ hồ',
      'Bình yên',
      'Hưng phấn',
      'Buồn',
      'Hạnh phúc',
      'Bất ổn',
      'Bất lực',
      'Lo âu',
      'Biết ơn',
      'Yêu thương',
      'Tức giận',
      'Bình thản',
      'Sáng tạo',
      'Phân tâm',
      'Quyết tâm',
      'Tự ti',
      'Hoài niệm',
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 18),
      physics: const BouncingScrollPhysics(),
      children: [
        const Text(
          'Cảm xúc hiện tại của bạn\nlà gì?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            height: 1.25,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 30),
        Text(
          'Tôi cảm thấy...',
          style: TextStyle(color: Colors.white.withOpacity(.45), fontSize: 16),
        ),
        const SizedBox(height: 26),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.22,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final active = selected.contains(item);
            return GestureDetector(
              onTap: () => onToggle(item),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? AppColors.violet : const Color(0xFF171061),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  item,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ActivityPage extends StatelessWidget {
  const _ActivityPage({required this.selected, required this.onToggle});

  final Set<String> selected;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final items = [
      'Thể thao',
      'Tình yêu',
      'Bạn bè',
      'Công việc',
      'Học',
      'Chăm sóc',
      'Việc nhà',
      'Thiên nhiên',
      'Thư giãn',
    ];
    return ListView(
      padding: const EdgeInsets.fromLTRB(26, 28, 26, 18),
      children: [
        const Text(
          'Có gì mới hôm nay?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            final item = items[index];
            final active = selected.contains(item);
            return GestureDetector(
              onTap: () => onToggle(item),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active ? AppColors.violet : const Color(0xFF171061),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('😡', style: TextStyle(fontSize: 22)),
                    const SizedBox(height: 8),
                    Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 26),
        const Text(
          'Thói quen đã hoàn thành',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 14),
        ...[
          ('Đọc tin tức tiếng Anh', true, Icons.psychology_alt),
          ('Đi chơi', false, Icons.diversity_3),
          ('Gặp gỡ bạn bè', false, Icons.handshake),
        ].map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.22),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Row(
              children: [
                Icon(item.$3, color: const Color(0xFFA7A0FF), size: 32),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.$1,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  item.$2 ? Icons.check_box : Icons.check_box_outline_blank,
                  color: item.$2 ? AppColors.mint : Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _NotePage extends StatelessWidget {
  const _NotePage({required this.controller, required this.onDone});

  final TextEditingController controller;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 26, 18, 20),
      children: [
        const Text(
          'Thêm ghi chú về bất cứ điều gì bạn\nnghĩ và cảm nhận.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            height: 1.35,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controller,
          minLines: 12,
          maxLines: 18,
          style: const TextStyle(color: Colors.white, fontSize: 17),
          decoration: InputDecoration(
            hintText: 'Ghi Chú',
            hintStyle: TextStyle(color: Colors.white.withOpacity(.45)),
            border: InputBorder.none,
          ),
        ),
        const SizedBox(height: 24),
        PrimaryButton(label: 'Hoàn thành', onPressed: onDone),
      ],
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({
    required this.showNav,
    required this.onBack,
    required this.onNext,
  });

  final bool showNav;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    if (showNav) return const SizedBox.shrink();
    return Container(
      height: 92,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF2B2373).withOpacity(.96),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          ),
          const Spacer(),
          FloatingActionButton(
            onPressed: onNext,
            backgroundColor: AppColors.mint,
            foregroundColor: Colors.black,
            child: const Icon(Icons.arrow_forward, size: 28),
          ),
        ],
      ),
    );
  }
}

class _TagRow extends StatelessWidget {
  const _TagRow({required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 9,
      runSpacing: 9,
      children: tags
          .map(
            (tag) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF563DB7),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                tag,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ActivityMini extends StatelessWidget {
  const _ActivityMini({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 7),
        Text(label, style: const TextStyle(color: Color(0xFF211C35))),
      ],
    );
  }
}

class _WeekBars extends StatelessWidget {
  const _WeekBars();

  @override
  Widget build(BuildContext context) {
    final values = [1, 3, 4, 0, 0, 5, 0];
    final colors = [
      Colors.red,
      Colors.orange,
      AppColors.cream,
      Colors.transparent,
      Colors.transparent,
      AppColors.mint,
      Colors.transparent,
    ];
    final labels = ['Fri', 'Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu'];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(values.length, (i) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              values[i] == 0 ? '' : '${values[i]}',
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
            const SizedBox(height: 4),
            Container(
              width: 13,
              height: 18.0 + values[i] * 14,
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              labels[i],
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        );
      }),
    );
  }
}
