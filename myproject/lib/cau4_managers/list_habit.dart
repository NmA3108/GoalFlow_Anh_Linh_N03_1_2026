import '../cau3_models/habit.dart';

class ListHabit {
  List<Habit> habits = [];

  // CREATE
  void addHabit(Habit habit) {
    habits.add(habit);
  }

  // READ
  void getAllHabits() {
    for (var h in habits) {
      h.display();
    }
  }

  // UPDATE
  void updateHabit(int id,
      {String? tenHabit, String? tanSuat, String? thoiGianNhac}) {
    for (var h in habits) {
      if (h.id == id) {
        h.update(
          tenHabit: tenHabit,
          tanSuat: tanSuat,
          thoiGianNhac: thoiGianNhac,
        );
      }
    }
  }

  // DELETE (bonus cho xịn)
  void deleteHabit(int id) {
    habits.removeWhere((h) => h.id == id);
  }
}