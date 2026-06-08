import 'package:flutter/material.dart';

import '../theme/app_design.dart';
import 'auth_pages.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 34),
        physics: const BouncingScrollPhysics(),
        children: [
          IconButton(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          const SizedBox(height: 14),
          const Text(
            'Cài đặt',
            style: TextStyle(
              color: Colors.white,
              fontSize: 31,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          GlassCard(
            radius: 9,
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF004A4B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.auto_awesome, color: Colors.white),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tải neurolist.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Ứng dụng lập kế hoạch hằng ngày dựa trên AI',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _SettingsSection(
            title: 'Tài khoản',
            children: const [
              Text('Email của bạn', style: TextStyle(color: Color(0xFFD6D0F4))),
              SizedBox(height: 8),
              Text(
                'maingoclinh412005@gmail.com',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SettingsSection(
            title: 'Cài đặt chung',
            children: const [
              _SettingToggle(label: 'Chế độ tối', active: false),
              _SettingToggle(
                label: 'Hiển thị kiểm tra trách nhiệm',
                active: false,
              ),
              _SettingToggle(
                label: 'Hiển thị các thói quen sắp tới',
                active: true,
              ),
              _SettingToggle(
                label: 'Hiển thị kiểm tra tâm trạng hằng ngày',
                active: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          _SettingAction(
            icon: Icons.card_giftcard,
            label: 'Thay đổi thứ tự thói quen',
            color: Colors.white.withOpacity(.25),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          _SettingAction(
            icon: Icons.card_giftcard,
            label: 'Mở khóa Premium',
            color: AppColors.mint,
            textColor: Colors.black,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PricePage()),
            ),
          ),
          const SizedBox(height: 20),
          _SettingAction(
            icon: Icons.star,
            label: 'Đánh giá ứng dụng 5 sao',
            color: AppColors.violet,
            onTap: () {},
          ),
          const SizedBox(height: 20),
          _SettingAction(
            icon: Icons.card_giftcard,
            label: 'Liên hệ nhà phát triển\nthomas@proddy.app',
            color: Colors.white.withOpacity(.25),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          _SettingAction(
            icon: Icons.card_giftcard,
            label: 'Chia sẻ với bạn bè',
            color: Colors.white.withOpacity(.25),
            onTap: () {},
          ),
          const SizedBox(height: 24),
          _PlainAction(
            icon: Icons.card_giftcard,
            label: 'Giấy phép',
            onTap: () {},
          ),
          _PlainAction(
            icon: Icons.card_giftcard,
            label: 'Đăng xuất',
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            ),
          ),
          _PlainAction(
            icon: Icons.delete_outline,
            label: 'Xóa tài khoản',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class PricePage extends StatelessWidget {
  const PricePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 30),
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              const Spacer(),
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.cream, AppColors.violet],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 28),
          const Text(
            'Phát huy tiềm năng của bạn',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 20),
          ...[
            'Không giới hạn thói quen & nhật ký',
            'Không giới hạn thói quen & nhật ký',
            'Đánh bại sự trì hoãn',
            'Thống kê tâm trạng & thói quen',
            'Động lực hằng ngày',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppColors.mint),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _PlanCard(
            highlight: true,
            title: 'Gói năm',
            price: '209.000đ',
            subtitle: 'Chỉ dưới 17.417đ mỗi tháng',
          ),
          const SizedBox(height: 26),
          _PlanCard(highlight: false, title: 'Gói tháng', price: '92.000đ'),
          const SizedBox(height: 28),
          const Center(
            child: Text(
              'Năm 2021\nĐược Apple giới thiệu',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 14),
          const Center(
            child: Text(
              '200k+ người dùng',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 26),
          const Text(
            'Người dùng nói gì:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          GlassCard(
            radius: 9,
            color: const Color(0xFF3F318B).withOpacity(.85),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Ứng dụng tuyệt vời!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Spacer(),
                    Text('nngoclinh', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  '★★★★★',
                  style: TextStyle(color: AppColors.cream, fontSize: 19),
                ),
                SizedBox(height: 14),
                Text(
                  'Cho đến nay đây là ứng dụng đẹp và trực quan nhất để theo dõi thói quen mà tôi từng dùng.',
                  style: TextStyle(color: Colors.white, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Điều khoản đăng ký',
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Tài khoản iTunes của bạn sẽ bị tính phí theo gói đã chọn. Bạn có thể quản lý đăng ký trong phần tài khoản.',
            style: TextStyle(color: Colors.white60, height: 1.45),
          ),
          const SizedBox(height: 26),
          PrimaryButton(
            label: 'Tiếp tục',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class EditHabitPage extends StatelessWidget {
  const EditHabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          const SizedBox(height: 46),
          const Text(
            'Name',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          _EditBox(
            child: Row(
              children: const [
                Text(
                  'Học Tiếng Anh',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Spacer(),
                Text('17/40', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Xóa thói quen',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 42),
          const Text(
            'Nhắc nhở',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          _EditBox(
            child: Row(
              children: const [
                Text(
                  '06:00',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Spacer(),
                Switch(value: true, onChanged: null),
              ],
            ),
          ),
          const SizedBox(height: 34),
          const Text(
            'Lý do',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          const _EditBox(
            height: 120,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Học Tiếng Anh',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 44,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.violet,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: const Text(
                'Chỉnh sửa thói quen',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 14,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children:
                [
                      'Thứ Hai',
                      'Thứ Ba',
                      'Thứ Tư',
                      'Thứ Năm',
                      'Thứ Sáu',
                      'Thứ Bảy',
                      'Chủ Nhật',
                    ]
                    .map(
                      (d) => Chip(
                        label: Text(d),
                        backgroundColor:
                            d == 'Thứ Ba' || d == 'Thứ Năm' || d == 'Chủ Nhật'
                            ? AppColors.violet
                            : Colors.white,
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 32),
          GlassCard(
            radius: 9,
            color: const Color(0xFF171061),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _HabitType(label: 'Mind', icon: Icons.layers),
                _HabitType(
                  label: 'Tâm trí',
                  icon: Icons.psychology_alt,
                  active: true,
                ),
                _HabitType(label: 'Mind', icon: Icons.spa),
              ],
            ),
          ),
          const SizedBox(height: 28),
          PrimaryButton(label: 'Lưu', onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }
}

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      showStatus: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(42, 90, 42, 28),
        child: Column(
          children: [
            const Text(
              'Nhắc Nhở',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 54),
            Container(
              height: 280,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF231067),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '08        07',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.55),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 18),
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
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '10        09        PM',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.55),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Text('Hoặc', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 28),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hủy Nhắc Nhở'),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'Hoàn Thành',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: 9,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Divider(color: Colors.white.withOpacity(.15), height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingToggle extends StatelessWidget {
  const _SettingToggle({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Switch(value: active, onChanged: (_) {}),
        ],
      ),
    );
  }
}

class _SettingAction extends StatelessWidget {
  const _SettingAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.textColor = Colors.white,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlainAction extends StatelessWidget {
  const _PlainAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.highlight,
    required this.title,
    required this.price,
    this.subtitle,
  });

  final bool highlight;
  final String title;
  final String price;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlight
            ? const Color(0xFF3A31C9).withOpacity(.65)
            : const Color(0xFF5D42B3),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          color: highlight ? AppColors.cream : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          if (highlight)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cream,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Giá trị tốt nhất',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2A194B),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          const SizedBox(height: 14),
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              Text(
                price,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 16),
            Text(subtitle!, style: const TextStyle(color: Colors.white54)),
          ],
        ],
      ),
    );
  }
}

class _EditBox extends StatelessWidget {
  const _EditBox({required this.child, this.height = 56});

  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.32),
        borderRadius: BorderRadius.circular(9),
      ),
      child: child,
    );
  }
}

class _HabitType extends StatelessWidget {
  const _HabitType({
    required this.label,
    required this.icon,
    this.active = false,
  });

  final String label;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFEEDCFF),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: active ? AppColors.violet : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.violet, size: 42),
          const SizedBox(height: 10),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF30213B),
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
