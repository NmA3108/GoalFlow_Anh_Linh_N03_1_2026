import 'package:flutter/material.dart';

import '../theme/app_design.dart';

class CreateHabitFlowPage extends StatefulWidget {
  const CreateHabitFlowPage({super.key});

  @override
  State<CreateHabitFlowPage> createState() => _CreateHabitFlowPageState();
}

class _CreateHabitFlowPageState extends State<CreateHabitFlowPage> {
  int _step = 0;
  final _nameController = TextEditingController(text: 'Luyện nghe tiếng Anh');
  final _reasonController = TextEditingController();
  String _area = 'Tâm trí';
  bool _daily = true;
  final Set<String> _days = {'Thứ Ba', 'Thứ Năm', 'Thứ Bảy'};
  bool _reminder = true;

  @override
  void dispose() {
    _nameController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _next() {
    if (_step < 4) {
      setState(() => _step++);
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã tạo thói quen mới')));
    Navigator.pop(context);
  }

  void _back() {
    if (_step == 0) {
      Navigator.pop(context);
    } else {
      setState(() => _step--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
            child: Row(
              children: [
                IconButton(
                  onPressed: _back,
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
          _ProgressDots(step: _step),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GlassCard(
                radius: 12,
                color: const Color(0xFF120A66).withOpacity(.72),
                borderColor: AppColors.violet.withOpacity(.75),
                padding: const EdgeInsets.fromLTRB(22, 36, 22, 24),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  child: _buildStep(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: PrimaryButton(
              label: _step == 4 ? 'Hoàn thành' : 'Tiếp tục',
              onPressed: _next,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0:
        return _NameStep(controller: _nameController);
      case 1:
        return _AreaStep(
          selected: _area,
          onSelect: (value) => setState(() => _area = value),
        );
      case 2:
        return _ScheduleStep(
          daily: _daily,
          days: _days,
          onDaily: () => setState(() => _daily = true),
          onCustom: () => setState(() => _daily = false),
          onToggleDay: (day) => setState(() {
            _daily = false;
            _days.contains(day) ? _days.remove(day) : _days.add(day);
          }),
        );
      case 3:
        return _ReasonStep(controller: _reasonController);
      default:
        return _ReminderStep(
          reminder: _reminder,
          onToggle: () => setState(() => _reminder = !_reminder),
        );
    }
  }
}

class _ProgressDots extends StatelessWidget {
  const _ProgressDots({required this.step});

  final int step;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final done = index <= step;
        return Container(
          width: 56,
          height: 32,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: done
                ? const Color(0xFF1F176B)
                : const Color(0xFF2A1B66).withOpacity(.72),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(
            Icons.check_circle,
            color: done ? AppColors.mint : Colors.white.withOpacity(.28),
            size: 18,
          ),
        );
      }),
    );
  }
}

class _NameStep extends StatelessWidget {
  const _NameStep({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('name'),
      children: [
        const Text(
          'Nhập tên cho\nthói quen của bạn',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.violetDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${controller.text.length}/40',
            style: TextStyle(
              color: Colors.white.withOpacity(.65),
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 34),
        Text(
          'Hãy bắt đầu với một thói quen thật dễ thực hiện. Làm vậy bạn sẽ không bị quá sức và bỏ cuộc.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(.58), height: 1.45),
        ),
      ],
    );
  }
}

class _AreaStep extends StatelessWidget {
  const _AreaStep({required this.selected, required this.onSelect});

  final String selected;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Tâm trí', Icons.psychology),
      ('Sức khỏe', Icons.spa),
      ('Tập trung', Icons.layers),
    ];
    return Column(
      key: const ValueKey('area'),
      children: [
        const Text(
          'Thói quen này\ncải thiện lĩnh vực nào?',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 34),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.map((item) {
            final active = selected == item.$1;
            return GestureDetector(
              onTap: () => onSelect(item.$1),
              child: Container(
                width: active ? 178 : 54,
                height: active ? 220 : 180,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF2B206D)
                      : const Color(0xFF241966),
                  border: Border.all(
                    color: active ? AppColors.violet : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: active
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.$2,
                            color: const Color(0xFFA7A0FF),
                            size: 78,
                          ),
                          const SizedBox(height: 18),
                          Text(
                            item.$1,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      )
                    : Icon(item.$2, color: Colors.white.withOpacity(.5)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _ScheduleStep extends StatelessWidget {
  const _ScheduleStep({
    required this.daily,
    required this.days,
    required this.onDaily,
    required this.onCustom,
    required this.onToggleDay,
  });

  final bool daily;
  final Set<String> days;
  final VoidCallback onDaily;
  final VoidCallback onCustom;
  final ValueChanged<String> onToggleDay;

  @override
  Widget build(BuildContext context) {
    final allDays = [
      'Thứ Hai',
      'Thứ Ba',
      'Thứ Tư',
      'Thứ Năm',
      'Thứ Sáu',
      'Thứ Bảy',
      'Chủ Nhật',
    ];
    return Column(
      key: const ValueKey('schedule'),
      children: [
        const Text(
          'Chọn thời điểm\nhoàn thành thói quen',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 26),
        Text(
          'Thói quen sẽ hình thành nhanh hơn nếu bạn làm mỗi ngày vào cùng một thời điểm.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(.55), height: 1.45),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 9,
          runSpacing: 12,
          children: [
            _ChipButton(
              label: 'Mỗi ngày',
              active: daily,
              color: AppColors.mint,
              onTap: onDaily,
            ),
            _ChipButton(
              label: 'Tùy chọn ngày',
              active: !daily,
              color: AppColors.cream,
              onTap: onCustom,
            ),
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 9,
          runSpacing: 12,
          children: allDays
              .map(
                (day) => _ChipButton(
                  label: day,
                  active: days.contains(day),
                  color: AppColors.violet,
                  onTap: () => onToggleDay(day),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _ReasonStep extends StatelessWidget {
  const _ReasonStep({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('reason'),
      children: [
        const Text(
          'Viết lý do để\ntự tạo động lực',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Không bắt buộc',
          style: TextStyle(color: Colors.white.withOpacity(.42)),
        ),
        const SizedBox(height: 28),
        TextField(
          controller: controller,
          minLines: 5,
          maxLines: 5,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Bởi vì....',
            hintStyle: TextStyle(color: Colors.white.withOpacity(.45)),
            filled: true,
            fillColor: AppColors.violetDark,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '0/300',
            style: TextStyle(color: Colors.white.withOpacity(.55)),
          ),
        ),
      ],
    );
  }
}

class _ReminderStep extends StatelessWidget {
  const _ReminderStep({required this.reminder, required this.onToggle});

  final bool reminder;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('reminder'),
      children: [
        const Text(
          'Thiết lập lời nhắc',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Tùy chọn',
          style: TextStyle(color: Colors.white.withOpacity(.42)),
        ),
        const SizedBox(height: 36),
        Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF2B136C).withOpacity(.82),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '08     07     PM',
                style: TextStyle(
                  color: Colors.white.withOpacity(.45),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 13),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.cream,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  '09     08    AM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF242021),
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 13),
              Text(
                '10     09     PM',
                style: TextStyle(
                  color: Colors.white.withOpacity(.45),
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 34),
        Text('hoặc', style: TextStyle(color: Colors.white.withOpacity(.55))),
        const SizedBox(height: 22),
        ElevatedButton(
          onPressed: onToggle,
          style: ElevatedButton.styleFrom(
            backgroundColor: reminder ? AppColors.danger : AppColors.violet,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
          ),
          child: Text(reminder ? 'Không nhắc lại' : 'Tạo lời nhắc'),
        ),
      ],
    );
  }
}

class _ChipButton extends StatelessWidget {
  const _ChipButton({
    required this.label,
    required this.active,
    required this.color,
    required this.onTap,
  });

  final String label;
  final bool active;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: active ? color : const Color(0xFF1E1765),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active && color == AppColors.mint
                ? Colors.black
                : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
