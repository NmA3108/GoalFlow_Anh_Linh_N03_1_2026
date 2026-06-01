import 'dart:ui';
import 'package:flutter/material.dart';
import 'navigation/home_page_navigation.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Hàm hiển thị thanh menu BottomSheet từ phía dưới lên khi bấm dấu cộng
  void _showCreateMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Để lộ nền mờ phía sau
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: const Color(
                0xFF1B1464,
              ).withOpacity(0.85), // Màu tối đồng bộ nền chính
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 35),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thanh gạch ngang nhỏ trên cùng của BottomSheet giúp kéo vuốt xuống
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Mục 1: Tạo thói quen mới
                  _buildBottomSheetItem(
                    Icons.add_circle_outline,
                    "Tạo thói quen mới",
                    onTap: () {
                      Navigator.pop(context); // Đóng menu
                      // Thêm logic chuyển màn hình hoặc xử lý của bạn ở đây
                    },
                  ),
                  const SizedBox(height: 15),

                  // Mục 2: Nhật ký hàng ngày
                  _buildBottomSheetItem(
                    Icons.book_outlined,
                    "Nhật ký hàng ngày",
                    onTap: () {
                      Navigator.pop(context); // Đóng menu
                      // Thêm logic chuyển màn hình hoặc xử lý của bạn ở đây
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget bổ trợ tạo từng dòng tùy chọn trong Menu hiện lên
  Widget _buildBottomSheetItem(
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white30,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Nền Gradient cố định phía sau
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2E3192), Color(0xFF1B1464)],
              ),
            ),
          ),

          // 2. Nội dung chính có thể cuộn
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  _buildTopBar(),
                  const SizedBox(height: 15),

                  // --- BODY: Phần nội dung cuộn ---
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          _buildStreakCard(),
                          const SizedBox(height: 30),

                          const Text(
                            "Ngày hôm nay",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTaskCard(
                            "Học Tiếng Anh",
                            "08:40",
                            Icons.psychology,
                          ),
                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Nhiệm vụ hoàn thành",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_up,
                                color: Colors.white70.withOpacity(0.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _buildTaskCard(
                            "Học Tiếng Anh",
                            "08:40",
                            Icons.fitness_center,
                            isCompleted: true,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(
        context,
      ), // Truyền context vào đây để nhận sự kiện bấm mở popup
    );
  }

  // --- CÁC WIDGET GIAO DIỆN NỘI DUNG TRÊN MÀN HÌNH CHÍNH ---
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.card_giftcard, color: Colors.white, size: 24),
        ),
        Icon(Icons.tune, color: Colors.white.withOpacity(0.8), size: 26),
      ],
    );
  }

  Widget _buildStreakCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.purple.withOpacity(0.4),
            Colors.blue.withOpacity(0.3),
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "2 ngày liên tiếp",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    _buildStreakDot("T2", true),
                    const SizedBox(width: 15),
                    _buildStreakDot("T3", true),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Làm tốt lắm!",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakDot(String day, bool active) {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          color: active ? const Color(0xFF00E676) : Colors.white24,
          size: 26,
        ),
        const SizedBox(height: 4),
        Text(day, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  Widget _buildTaskCard(
    String title,
    String time,
    IconData icon, {
    bool isCompleted = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isCompleted ? 0.08 : 0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isCompleted
                    ? Colors.purpleAccent.withOpacity(0.5)
                    : Colors.purpleAccent,
                size: 40,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: isCompleted ? Colors.white38 : Colors.white60,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: TextStyle(
                      color: isCompleted ? Colors.white38 : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  4,
                  (index) => _buildSmallDot(index < 3 || isCompleted),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallDot(bool active) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF00E676) : Colors.white24,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // --- THANH ĐIỀU HƯỚNG DƯỚI (BOTTOM NAVIGATION BAR) ---
  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF16194F),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.check_circle_outline, context, isSelected: true),
          _buildNavItem(
            Icons.bar_chart_rounded,
            context,
            onTap: () => HomePageNavigation.navigateToInsightGeneral(context),
          ),
          _buildAddButton(context), // Truyền context vào nút dấu cộng
          _buildNavItem(
            Icons.favorite_border,
            context,
            onTap: () => HomePageNavigation.navigateToInsight(context),
          ),
          _buildNavItem(
            Icons.headphones_outlined,
            context,
            onTap: () => HomePageNavigation.navigateToReflection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    BuildContext context, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.4),
          size: 28,
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCreateMenu(
        context,
      ), // Gọi hàm hiển thị BottomSheet khi nhấn nút dấu cộng
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFB176FF), Color(0xFF8C46FF)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
