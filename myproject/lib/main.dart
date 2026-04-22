import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// User
var listUser = {'idUser': 1, 'tenUser': 'Mai Ngoc Linh'};

// Goal
var listGoal = [
  {
    'idGoal': 1,
    'tenGoal': 'Học tiếng Anh',
    'ngayBatDau': '15-04-2026',

    'ngayKetThuc': '30-04-2026',
    'tienDo': 0.5,
  },
  {
    'idGoal': 2,
    'tenGoal': 'Tập thể dục',
    'ngayBatDau': '15-04-2026',
    'ngayKetThuc': '20-04-2026',
    'tienDo': 0.7,
  },
];

// Habit
var listHabit = [
  {
    'idHabit': 1,
    'tenHabit': 'Uống nước',
    'tanSuat': 'Hàng ngày',
    'thoiGianNhac': '08:00',
  },
  {
    'idHabit': 2,
    'tenHabit': 'Đọc sách',
    'tanSuat': 'Thứ 2-4-6',
    'thoiGianNhac': '20:00',
  },
];

// ================== APP ==================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoalFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const HomePage(),
    );
  }
}

// ================== UI ==================

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GoalFlow")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USER
            Text(
              "Xin chào, ${listUser['tenUser']}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            // GOALS
            const Text(
              " Danh sách Goal",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...listGoal.map((goal) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(goal['tenGoal'].toString()),
                      Text(
                        "${((goal['tienDo'] as double) * 100).toInt()}%",
                        style: const TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // HABITS
            const Text(
              "🔥 Danh sách Habit",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ...listHabit.map((habit) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(habit['tenHabit'].toString()),
                      Text(habit['tanSuat'].toString()),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
