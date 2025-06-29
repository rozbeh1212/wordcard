// lib/main.dart

import 'package:flutter/material.dart';
import 'ui/screens/word_detail_screen.dart';

void main() {
  // ایستگاه بازرسی ۱
  print("--- CHECKPOINT 1: main() function started. ---");

  runApp(const MyApp());

  // ایستگاه بازرسی ۲
  print("--- CHECKPOINT 2: runApp() function called. ---");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ایستگاه بازرسی ۳
    print("--- CHECKPOINT 3: MyApp build method is running. ---");

    return MaterialApp(
      title: 'Word Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WordDetailScreen(),
      themeMode: ThemeMode.dark,
    );
  }
}