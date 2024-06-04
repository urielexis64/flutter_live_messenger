import 'package:flutter/material.dart';
import 'package:msn/app_constants.dart';
import 'package:msn/auth/splash_page.dart';
import 'package:msn/utils.dart';

void main() async {
  await Utils.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Live Messenger',
      theme: appTheme,
      home: const SplashPage(),
    );
  }
}
