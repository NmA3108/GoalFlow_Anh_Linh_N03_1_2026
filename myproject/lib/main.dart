import 'package:flutter/material.dart';

import 'MyHomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on UnsupportedError catch (error) {
    debugPrint('Firebase is not configured for this platform: $error');
  } catch (error) {
    debugPrint('Firebase initialization skipped: $error');
  }
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
      home: const MyHomePage(),
    );
  }
}
