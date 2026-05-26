import 'Goal.dart';

class HabitGoal extends Goal {
  int soNgayDaLam;
  int tongSoNgayMucTieu;

  // SỬA CHỖ NÀY: Tên hàm khởi tạo phải trùng với tên Class (HabitGoal)
  HabitGoal({
    required super.idGoal,
    required super.tenGoal,
    required super.ngayBatDau,
    required super.ngayKetThuc,
    required this.soNgayDaLam,
    required this.tongSoNgayMucTieu,
  });

  @override
  double tinhTienDo() {
    return soNgayDaLam / tongSoNgayMucTieu;
  }
}
