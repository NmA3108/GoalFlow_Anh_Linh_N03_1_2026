import 'dart:ui';
import 'package:flutter/material.dart';

class ReflectionPage extends StatefulWidget {
  const ReflectionPage({super.key});

  @override
  State<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends State<ReflectionPage> {
  // Biến lưu trạng thái Icon cảm xúc được chọn (0: Rất tệ -> 4: Tuyệt vời)
  int _selectedMoodIndex = 2; // Mặc định chọn biểu cảm bình thường

  // Danh sách các biểu tượng cảm xúc và nhãn tương ứng
  final List<Map<String, dynamic>> _moods = [
    {"icon": "😢", "label": "Tệ"},
    {"icon": "😔", "label": "Hơi buồn"},
    {"icon": "😐", "label": "Bình thường"},
    {"icon": "🙂", "label": "Vui vẻ"},
    {"icon": "🤩", "label": "Tuyệt vời"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Nền Gradient tối đồng bộ thiết kế toàn app
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF2E3192), Color(0xFF1B1464)],
              ),
            ),
          ),

          // 2. Nội dung giao diện bên trong
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
                    // Tiêu đề đầu trang
                    _buildHeader(),
                    const SizedBox(height: 25),

                    // Thanh cuộn lịch ngày tháng ngang
                    _buildDateTimeline(),
                    const SizedBox(height: 30),

                    // Khu vực chọn tâm trạng ngày hôm nay
                    const Text(
                      "Tâm trạng của bạn hôm nay thế nào?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildMoodTracker(),
                    const SizedBox(height: 35),

                    // Ô viết nhật ký phản chiếu
                    const Text(
                      "Ghi lại suy nghĩ của bạn",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildReflectionInput(),
                    const SizedBox(height: 30),

                    // Nút Lưu nhật ký
                    _buildSaveButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget: Header gồm chữ tiêu đề và nút icon chức năng nhỏ
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Reflection",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
            size: 22,
          ),
        ),
      ],
    );
  }

  // Widget: Thanh lịch cuộn ngang giả lập dòng thời gian trong tuần
  Widget _buildDateTimeline() {
    // Dữ liệu giả lập các ngày trong tuần
    final List<Map<String, String>> days = [
      {"day": "Mon", "date": "25"},
      {"day": "Tue", "date": "26"},
      {"day": "Wed", "date": "27"},
      {"day": "Thu", "date": "28"},
      {"day": "Fri", "date": "29"},
      {"day": "Sat", "date": "30"},
      {"day": "Sun", "date": "31"},
    ];

    String currentSelectedDate =
        "28"; // Giả lập ngày đang chọn là thứ 5 ngày 28

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((item) {
        bool isSelected = item["date"] == currentSelectedDate;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF8C46FF)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : Colors.white.withOpacity(0.03),
            ),
          ),
          child: Column(
            children: [
              Text(
                item["day"]!,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white38,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item["date"]!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Widget: Khu vực bấm chọn các trạng thái Mood
  Widget _buildMoodTracker() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_moods.length, (index) {
          bool isSelected = _selectedMoodIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedMoodIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected
                      ? Colors.white.withOpacity(0.15)
                      : Colors.transparent,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    _moods[index]["icon"],
                    style: const TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _moods[index]["label"],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white38,
                      fontSize: 11,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // Widget: Hộp nhập văn bản ghi nhật ký nhiều dòng phong cách Glassmorphism
  Widget _buildReflectionInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: TextField(
              maxLines: 8, // Cho phép hiển thị tối đa rộng 8 dòng nhập dữ liệu
              keyboardType: TextInputType.multiline,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
              cursorColor: const Color(0xFF8C46FF),
              decoration: InputDecoration(
                hintText:
                    "Hôm nay bạn đã làm được những gì? Có điều gì làm bạn học hỏi được hoặc cần cải thiện không? Hãy viết ra đây nhé...",
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.25),
                  fontSize: 14,
                  height: 1.4,
                ),
                border: InputBorder
                    .none, // Ẩn đường gạch chân thô mặc định của TextField
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget: Nút Lưu nhật ký (Save Button) góc bo với dải màu Gradient nổi bật
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          // Xử lý sự kiện lưu thông tin phản chiếu ở đây
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Đã lưu nhật ký phản chiếu hôm nay!")),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: const Color(0xFF8C46FF).withOpacity(0.3),
          elevation: 5,
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFB176FF), Color(0xFF8C46FF)],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Lưu nhật ký",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
