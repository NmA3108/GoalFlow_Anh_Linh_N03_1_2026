class Habit {
  int id;
  String tenHabit;
  String tanSuat;
  String thoiGianNhac;

  Habit({
    required this.id,
    required this.tenHabit,
    required this.tanSuat,
    required this.thoiGianNhac,
  });

  // Hiển thị thông tin
  void display() {
    print("Habit: $tenHabit - Tần suất: $tanSuat - Nhắc: $thoiGianNhac");
  }

  // Update thông tin habit
  void update({
    String? tenHabit,
    String? tanSuat,
    String? thoiGianNhac,
  }) {
    if (tenHabit != null) this.tenHabit = tenHabit;
    if (tanSuat != null) this.tanSuat = tanSuat;
    if (thoiGianNhac != null) this.thoiGianNhac = thoiGianNhac;
  }
}