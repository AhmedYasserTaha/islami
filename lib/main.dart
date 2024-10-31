import 'package:flutter/material.dart';
import 'package:islami_app/splash_screen.dart';

void main() {
  runApp(const IslamiApp());
}

class IslamiApp extends StatelessWidget {
  const IslamiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Islami App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
