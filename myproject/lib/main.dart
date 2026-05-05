import 'package:flutter/material.dart';
import 'front/BotNavi.dart';

import 'MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Tracker UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Thiết lập giao diện tối để phù hợp với phong cách Glassmorphism
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1B1464), // Màu nền gốc tối
      ),
      home: BotNavi(),
    );
  }
}
