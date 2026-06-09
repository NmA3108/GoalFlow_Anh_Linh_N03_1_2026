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

  void display() {
    print(
      "Habit: $tenHabit - Tần suất: $tanSuat - Nhắc: $thoiGianNhac",
    );
  }

  void update({
    String? tenHabit,
    String? tanSuat,
    String? thoiGianNhac,
  }) {
    if (tenHabit != null) {
      this.tenHabit = tenHabit;
    }

    if (tanSuat != null) {
      this.tanSuat = tanSuat;
    }

    if (thoiGianNhac != null) {
      this.thoiGianNhac = thoiGianNhac;
    }
  }

  @override
  String toString() {
    return "$tenHabit - $tanSuat";
  }
}