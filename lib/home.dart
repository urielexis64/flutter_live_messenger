import 'dart:math';

import 'package:flutter/material.dart';
import 'package:msn/login.dart';
import 'package:vibration/vibration.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  final int fps = 60;
  double maxOffset = 15;
  Offset offset = const Offset(0, 0);
  final ran = Random();

  AnimationController? controller;
  Animation<Offset>? animation;

  Offset get randomOffset {
    final value = ran.nextDouble() * maxOffset - maxOffset / 2;
    return Offset(value, value);
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      animationBehavior: AnimationBehavior.preserve,
    );

    animation = TweenSequence<Offset>([
      for (var i = 0; i < fps; i++)
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: offset,
            end: randomOffset,
          ),
          weight: 1,
        ),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: offset,
          end: offset,
        ),
        weight: 1,
      ),
    ]).animate(controller!);

    animation!.addListener(() {
      setState(() {
        offset = animation!.value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Transform.translate(
          offset: offset,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () async {
                    await obtainAuthenticatedClient();
                  },
                ),
              ],
            ),
            body: Center(
              child: TextButton(
                child: const Text('Zumbido'),
                onPressed: () {
                  controller!.forward(from: 0);
                  Vibration.vibrate(duration: 1000);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
