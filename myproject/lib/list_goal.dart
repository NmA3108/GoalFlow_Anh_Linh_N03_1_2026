import 'Goal.dart'; // Import file chứa class Goal của bạn

class ListGoal {
  // --- Biến danh sách của Tenclass ---
  List<Goal> danhSachGoal = [];

  // --- 1. CREATE: Thêm một bản ghi mới ---
  void create(Goal newGoal) {
    danhSachGoal.add(newGoal);
    print('Đã thêm mục tiêu: ${newGoal.tenGoal} thành công!');
  }

  // --- 2. READ: Đọc tất cả các bản ghi ---
  void readAll() {
    print('\n========== DANH SÁCH MỤC TIÊU ==========');
    if (danhSachGoal.isEmpty) {
      print('Danh sách đang trống.');
    } else {
      for (var goal in danhSachGoal) {
        goal.hienThiThongTin();
        print('--------------------------');
      }
    }
  }

  // --- 3. EDIT: Sửa bản ghi theo ID cụ thể ---
  void edit(int id, {String? tenMoi, double? tienDoMoi}) {
    try {
      // Tìm vị trí của bản ghi có idGoal trùng với id truyền vào
      var goal = danhSachGoal.firstWhere((g) => g.idGoal == id);

      if (tenMoi != null) goal.tenGoal = tenMoi;
      if (tienDoMoi != null) goal.tienDo = tienDoMoi;

      print('Đã cập nhật bản ghi ID: $id thành công!');
    } catch (e) {
      print('Không tìm thấy mục tiêu nào có ID: $id để sửa.');
    }
  }

  // --- 4. DELETE: (Thêm thêm để đủ bộ CRUD) ---
  void delete(int id) {
    danhSachGoal.removeWhere((g) => g.idGoal == id);
    print('Đã xóa bản ghi ID: $id.');
  }
}
