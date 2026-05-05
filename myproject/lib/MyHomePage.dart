import 'dart:ui';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Nền Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2E3192), Color(0xFF1B1464)],
              ),
            ),
          ),

          // 2. Nội dung chính
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  // --- HEADER MỚI: Chứa ảnh, Tên trường và Tên SV ---
                  _buildHeader(),

                  // --- BODY: Phần nội dung cuộn ---
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          _buildTopBar(),
                          const SizedBox(height: 20),
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
                          const Text(
                            "Nhiệm vụ hoàn thành",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildTaskCard(
                            "Tập Thể Dục",
                            "17:30",
                            Icons.fitness_center,
                            isCompleted: true,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                  // Đã xóa _buildFooter() ở đây theo yêu cầu
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNav(),
    );
  }

  // --- HEADER CẬP NHẬT THEO ẢNH MỚI ---
  Widget _buildHeader() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              // Thông tin bên trái
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Lập trình mobile",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "PHENIKAA UNIVERSITY",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Nguyễn Minh Ánh - Mai Ngọc Linh",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Ảnh bên phải (Bo tròn)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.purpleAccent, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                    'https://scontent.fhan5-6.fna.fbcdn.net/v/t1.15752-9/679695211_1168293898703758_1880242053628299374_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=9f807c&_nc_eui2=AeG4ZMXl0r6VpdMxfzhrmF6TMp5sJFacrGwynmwkVpysbB_qCTYJud3O9tgetc2DmkDrgHVYv2phiHaCPnbBjSFJ&_nc_ohc=2IEsB5QBgIwQ7kNvwHdgt4x&_nc_oc=AdqxRRzgmLDjdCW1qTxDRSo5eEcYFpoQHE5q7hdaBywg9LcpYY-4w2KhUI7Ro40Uk-8&_nc_zt=23&_nc_ht=scontent.fhan5-6.fna&_nc_ss=7b2a8&oh=03_Q7cD5AHwhIY701F94T8dAi_oUzvRm9YUVXr7ym0nCRWKTb0QoA&oe=6A18D583',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- GIỮ LẠI CÁC WIDGET GIAO DIỆN CŨ ---
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.card_giftcard, color: Colors.white),
        ),
        const Icon(Icons.tune, color: Colors.white),
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
            Colors.purple.withOpacity(0.5),
            Colors.blue.withOpacity(0.5),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    _buildStreakDot("T2", true),
                    const SizedBox(width: 10),
                    _buildStreakDot("T3", true),
                  ],
                ),
              ],
            ),
          ),
          const Text("Làm tốt lắm!", style: TextStyle(color: Colors.white70)),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundColor: Colors.white24,
            child: Icon(Icons.arrow_forward, color: Colors.white),
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
          color: active ? Colors.greenAccent : Colors.white24,
        ),
        Text(day, style: const TextStyle(color: Colors.white, fontSize: 12)),
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
            color: Colors.white.withOpacity(isCompleted ? 0.05 : 0.15),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.purpleAccent, size: 40),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(time, style: const TextStyle(color: Colors.white60)),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                  4,
                  (index) => _buildSmallDot(index == 3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSmallDot(bool last) {
    return Container(
      margin: const EdgeInsets.only(left: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: last ? Colors.greenAccent : Colors.white24,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 85,
      decoration: BoxDecoration(
        color: const Color(0xFF1B1464),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, isSelected: true, label: "Home"),
          _buildNavItem(Icons.article_outlined, label: "Content"),
          _buildAddButton(),
          _buildNavItem(Icons.info_outline, label: "About"),
          _buildNavItem(Icons.person_outline, label: "Profile"),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      transform: Matrix4.translationValues(0, -10, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFAD1DEB), Color(0xFF6E48AA)],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(Icons.add, color: Colors.white, size: 28),
    );
  }

  Widget _buildNavItem(
    IconData icon, {
    bool isSelected = false,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.purpleAccent : Colors.white38,
          size: 26,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.purpleAccent : Colors.white38,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
