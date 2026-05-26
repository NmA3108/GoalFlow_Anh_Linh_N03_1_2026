import 'Goal.dart';
class QuantityGoal extends Goal {
  double daDatDuoc;
  double mucTieuCanDat;

  QuantityGoal({
    required super.idGoal,
    required super.tenGoal,
    required super.ngayBatDau,
    required super.ngayKetThuc,
    required this.daDatDuoc,
    required this.mucTieuCanDat,
  });

  // Công thức tính tiến độ riêng cho mục tiêu con số
  @override
  double tinhTienDo() {
    return daDatDuoc / mucTieuCanDat;
  }
}