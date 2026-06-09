import '../habit.dart';
import 'generic_manager.dart';

class ListHabit extends GenericManager<Habit> {

  void updateHabit(
    int id, {
    String? tenHabit,
    String? tanSuat,
    String? thoiGianNhac,
  }) {
    for (var h in items) {
      if (h.id == id) {
        h.update(
          tenHabit: tenHabit,
          tanSuat: tanSuat,
          thoiGianNhac: thoiGianNhac,
        );
      }
    }
  }

  // Hiển thị Habit
  void showHabits() {
    for (var h in items) {
      h.display();
    }
  }
}