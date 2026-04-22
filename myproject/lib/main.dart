import 'package:flutter/material.dart';
import 'goal.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const GoalListScreen(),
    );
  }
}

class GoalListScreen extends StatefulWidget {
  const GoalListScreen({super.key});

  @override
  State<GoalListScreen> createState() => _GoalListScreenState();
}

class _GoalListScreenState extends State<GoalListScreen> {
  // Câu 4: Biến danh sách của Tenclass
  List<Goal> listGoals = [
    Goal(
      idGoal: 1,
      tenGoal: 'Học Flutter',
      ngayBatDau: '15/04',
      ngayKetThuc: '30/04',
      tienDo: 0.5,
    ),
  ];

  // Hàm Create & Edit
  void _upsertGoal({Goal? existingGoal}) {
    final nameController = TextEditingController(
      text: existingGoal?.tenGoal ?? '',
    );
    final progressController = TextEditingController(
      text: existingGoal?.tienDo.toString() ?? '0.0',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existingGoal == null ? 'Thêm mục tiêu' : 'Sửa mục tiêu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên mục tiêu'),
            ),
            TextField(
              controller: progressController,
              decoration: const InputDecoration(
                labelText: 'Tiến độ (0.0 - 1.0)',
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (existingGoal == null) {
                  // CREATE
                  listGoals.add(
                    Goal(
                      idGoal: DateTime.now().millisecondsSinceEpoch,
                      tenGoal: nameController.text,
                      ngayBatDau: '22/04',
                      ngayKetThuc: '30/12',
                      tienDo: double.tryParse(progressController.text) ?? 0.0,
                    ),
                  );
                } else {
                  // EDIT
                  existingGoal.tenGoal = nameController.text;
                  existingGoal.tienDo =
                      double.tryParse(progressController.text) ?? 0.0;
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Mục tiêu (CRUD)')),
      // READ: Hiển thị danh sách
      body: listGoals.isEmpty
          ? const Center(child: Text('Chưa có mục tiêu nào'))
          : ListView.builder(
              itemCount: listGoals.length,
              itemBuilder: (context, index) {
                final item = listGoals[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text('${(item.tienDo * 100).toInt()}%'),
                    ),
                    title: Text(item.tenGoal),
                    subtitle: Text(
                      'Từ: ${item.ngayBatDau} - Đến: ${item.ngayKetThuc}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _upsertGoal(existingGoal: item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() => listGoals.removeAt(index)); // DELETE
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _upsertGoal(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
