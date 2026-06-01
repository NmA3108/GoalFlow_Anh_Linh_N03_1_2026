import 'dart:ui';
import 'package:flutter/material.dart';

class InsightGeneralPage extends StatelessWidget {
  const InsightGeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Nền Gradient tối đồng bộ với toàn bộ ứng dụng
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2E3192), Color(0xFF1B1464)],
              ),
            ),
          ),

          // 2. Nội dung chính giao diện
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tiêu đề trang
                    const Text(
                      "Insights",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Thanh chuyển đổi Tab (General / Habit)
                    _buildTabBar(),
                    const SizedBox(height: 25),

                    // Thẻ tiến trình tổng quan (Vòng tròn % + Số ngày Streak)
                    _buildOverviewCard(),
                    const SizedBox(height: 15),

                    // Lưới hiển thị các thẻ chỉ số (Focus time + Completion rate)
                    _buildStatsGrid(),
                    const SizedBox(height: 15),

                    // Biểu đồ cột hàng tuần
                    _buildWeeklyChartCard(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget 1: Thanh chọn giữa "General" và "Habit"
  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF8C46FF), // Tab đang chọn màu tím nổi bật
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "General",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Habit",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget 2: Thẻ hiển thị tiến trình tổng quan (Hình tròn % bên trái)
  Widget _buildOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          // Vòng tròn hiển thị % tiến độ
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 75,
                height: 75,
                child: CircularProgressIndicator(
                  value: 0.68, // Tương đương 68%
                  strokeWidth: 8,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF00E676),
                  ), // Màu xanh lá khỏe khoắn
                ),
              ),
              const Text(
                "68%",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(width: 25),
          // Thông tin Text bên phải
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tuyệt vời!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Bạn đã duy trì được chuỗi thói quen 4 ngày liên tiếp.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget 3: Lưới chia 2 cột hiển thị các chỉ số chi tiết
  Widget _buildStatsGrid() {
    return Row(
      children: [
        // Thẻ Thời gian tập trung
        Expanded(
          child: _buildStatItem(
            icon: Icons.timer_outlined,
            iconColor: Colors.orangeAccent,
            title: "Focus time",
            value: "1.5 giờ",
          ),
        ),
        const SizedBox(width: 15),
        // Thẻ Tỷ lệ hoàn thành mục tiêu
        Expanded(
          child: _buildStatItem(
            icon: Icons.track_changes_outlined,
            iconColor: Colors.cyanAccent,
            title: "Completion",
            value: "82%",
          ),
        ),
      ],
    );
  }

  // Widget con hỗ trợ vẽ từng ô thống kê trong Lưới
  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget 4: Thẻ chứa Biểu đồ cột hàng tuần (Weekly Chart)
  Widget _buildWeeklyChartCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hiệu suất tuần này",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 25),
          // Khu vực hiển thị các cột đồ thị ghép hàng ngang
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar(day: "T2", fillPercent: 0.4, isActive: false),
              _buildBar(day: "T3", fillPercent: 0.7, isActive: false),
              _buildBar(
                day: "T4",
                fillPercent: 0.9,
                isActive: true,
              ), // Cột ngày hiện tại nổi bật hơn
              _buildBar(day: "T5", fillPercent: 0.5, isActive: false),
              _buildBar(day: "T6", fillPercent: 0.3, isActive: false),
              _buildBar(day: "T7", fillPercent: 0.8, isActive: false),
              _buildBar(day: "CN", fillPercent: 0.2, isActive: false),
            ],
          ),
        ],
      ),
    );
  }

  // Widget hỗ trợ vẽ từng cột đơn lẻ trong biểu đồ tuần
  Widget _buildBar({
    required String day,
    required double fillPercent,
    required bool isActive,
  }) {
    const double maxChartHeight = 130.0; // Chiều cao tối đa của cột biểu đồ

    return Column(
      children: [
        Container(
          height: maxChartHeight,
          width: 14,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08), // Phần nền cột trống bên sau
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment
              .bottomCenter, // Đảm bảo phần dữ liệu được lấp từ dưới lên
          child: FractionallySizedBox(
            heightFactor:
                fillPercent, // Tỷ lệ chiều cao dữ liệu lấp đầy cột (từ 0.0 đến 1.0)
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isActive
                      ? [
                          const Color(0xFF00E676),
                          const Color(0xFF00B0FF),
                        ] // Xanh tươi nếu là ngày hiện tại
                      : [
                          const Color(0xFFB176FF),
                          const Color(0xFF8C46FF),
                        ], // Tím tiêu chuẩn cho các ngày khác
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          day,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.white54,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
