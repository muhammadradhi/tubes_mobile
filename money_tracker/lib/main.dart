import 'package:flutter/material.dart';
import 'pages/main_shell.dart';

void main() {
  runApp(const MoneyTrackerApp());
}

class MoneyTrackerApp extends StatelessWidget {
  const MoneyTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        useMaterial3: true,
      ),
      home: const MainShell(),
    );
  }
}