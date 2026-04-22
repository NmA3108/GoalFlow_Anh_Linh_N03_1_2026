class Goal {
  // --- Các biến (Attributes) ---
  int idGoal; // Mã định danh mục tiêu
  String tenGoal; // Tên mục tiêu
  String ngayBatDau; // Ngày bắt đầu (định dạng dd-mm-yyyy)
  String ngayKetThuc; // Ngày kết thúc
  double tienDo; // Tiến độ công việc (từ 0.0 đến 1.0)

  // Constructor (Hàm khởi tạo)
  Goal({
    required this.idGoal,
    required this.tenGoal,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.tienDo,
  });

  // --- Các phương thức (Methods) ---

  // 1. Phương thức hiển thị thông tin chi tiết của mục tiêu
  void hienThiThongTin() {
    print('Mục tiêu [$idGoal]: $tenGoal');
    print('- Thời gian: $ngayBatDau đến $ngayKetThuc');
    print('- Tiến độ: ${(tienDo * 100).toStringAsFixed(0)}%');
  }

  // 2. Phương thức cập nhật tiến độ mới
  void capNhatTienDo(double moi) {
    if (moi >= 0 && moi <= 1) {
      tienDo = moi;
      print('Đã cập nhật tiến độ cho "$tenGoal" thành ${(tienDo * 100)}%');
    } else {
      print('Giá trị tiến độ không hợp lệ!');
    }
  }

  // 3. Kiểm tra xem mục tiêu đã hoàn thành chưa (tiến độ = 100%)
  bool laHoanThanh() {
    return tienDo >= 1.0;
  }
}
