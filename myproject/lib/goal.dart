// LỚP CHA TỔNG QUÁT - Chứa các thuộc tính và phương thức chung
abstract class Goal {
  // 1. Tổng quát hóa thuộc tính: Mục tiêu nào cũng cần có 4 thông tin này
  int idGoal;
  String tenGoal;
  String ngayBatDau;
  String ngayKetThuc;

  // Hàm khởi tạo (Constructor) của lớp cha
  Goal({
    required this.idGoal,
    required this.tenGoal,
    required this.ngayBatDau,
    required this.ngayKetThuc,
  });

  // 2. Tổng quát hóa phương thức: Tạo ra cái tên hàm chung, không viết công thức ở đây
  double tinhTienDo();

  // Getter cho tienDo
  double get tienDo => tinhTienDo();

  // Phương thức hiển thị thông tin chung
  void hienThiThongTin() {
    print('Mục tiêu [$idGoal]: $tenGoal');
    print('- Thời gian: $ngayBatDau đến $ngayKetThuc');
    // Gọi hàm tinhTienDo() tổng quát
    print('- Tiến độ: ${(tinhTienDo() * 100).toStringAsFixed(0)}%');
  }
}
