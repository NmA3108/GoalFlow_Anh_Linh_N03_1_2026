import 'dart:ui';
import 'package:flutter/material.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  // Dữ liệu mẫu danh sách bài viết nhật ký phản chiếu
  final List<Map<String, dynamic>> _insightData = const [
    {
      "day": "Thứ Năm",
      "date": "28 Tháng 5",
      "mood": "🤩",
      "moodLabel": "Tuyệt vời",
      "content":
          "Hôm nay là một ngày làm việc cực kỳ năng suất! Mình đã hoàn thành xong phần thiết kế giao diện cho app theo dõi thói quen, fix được cái bug giao diện Bottom Sheet và dành ra được 45 phút chạy bộ buổi tối. Cảm giác duy trì được kỷ luật bản thân rất phấn khích.",
    },
    {
      "day": "Thứ Tư",
      "date": "27 Tháng 5",
      "mood": "🙂",
      "moodLabel": "Vui vẻ",
      "content":
          "Học thêm được cách tổ chức cấu trúc dữ liệu NoSQL trong Firebase rất hay. Mình đã hiểu cách nhúng trực tiếp danh sách Habit vào trong Document Goal để tối ưu hóa truy vấn. Buổi chiều trời mưa hơi lười một chút nhưng vẫn ép bản thân đọc được 10 trang sách.",
    },
    {
      "day": "Thứ Ba",
      "date": "26 Tháng 5",
      "mood": "😐",
      "moodLabel": "Bình thường",
      "content":
          "Một ngày trôi qua khá nhẹ nhàng, không có quá nhiều biến động. Tiến độ công việc ở mức vừa phải. Cần chú ý tập trung hơn vào buổi chiều vì tầm 3h-4h mắt hay bị mỏi và dễ lướt điện thoại mất thời gian.",
    },
  ];

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

          // 2. Nội dung hiển thị lớp trên cùng
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header chứa nút Back và tiêu đề "Insight"
                _buildHeader(context),

                // Danh sách cuộn các thẻ Insight Card
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _insightData.length,
                    itemBuilder: (context, index) {
                      final item = _insightData[index];
                      return _buildInsightCard(
                        day: item["day"],
                        date: item["date"],
                        mood: item["mood"],
                        moodLabel: item["moodLabel"],
                        content: item["content"],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget: Header bao gồm nút mũi tên quay lại và tiêu đề "Insight"
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20, top: 15, bottom: 15),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 22,
            ),
            onPressed: () {
              Navigator.pop(
                context,
              ); // Quay lại màn hình chính hoặc màn hình trước đó
            },
          ),
          const SizedBox(width: 5),
          const Text(
            "Insight",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // Widget: Thẻ Card Kính mờ (Glassmorphism) hiển thị chi tiết bài viết
  Widget _buildInsightCard({
    required String day,
    required String date,
    required String mood,
    required String moodLabel,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(
          0.06,
        ), // Độ mờ nền tạo cảm giác như kính trong suốt
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withOpacity(
            0.05,
          ), // Đường viền mờ siêu mảnh định hình khối Card
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 12,
            sigmaY: 12,
          ), // Làm mờ vùng nền phía sau Card
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Phần đầu Card: Thời gian bên trái, Trạng thái cảm xúc bên phải
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cột Thứ và Ngày tháng
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    // Khối chip bo tròn hiển thị Icon cảm xúc và Nhãn tâm trạng
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(mood, style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 6),
                          Text(
                            moodLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Đường vạch ngang mờ tinh tế phân cách nội dung
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    color: Colors.white.withOpacity(0.08),
                    height: 1,
                  ),
                ),

                // Nội dung nhật ký phản chiếu chữ màu trắng sáng, giãn dòng thoáng
                Text(
                  content,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                    height:
                        1.5, // Giúp các dòng chữ không bị dính vào nhau khi viết dài
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
