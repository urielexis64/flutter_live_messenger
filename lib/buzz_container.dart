import 'dart:math';

import 'package:flutter/material.dart';

class BuzzContainer extends StatefulWidget {
  const BuzzContainer({super.key, required this.child, required this.onInit});

  final Widget child;
  final void Function(AnimationController controller) onInit;

  @override
  State<BuzzContainer> createState() => _BuzzContainerState();
}

class _BuzzContainerState extends State<BuzzContainer>
    with SingleTickerProviderStateMixin {
  final int fps = 60;
  double maxOffset = 5;
  Offset offset = const Offset(0, 0);
  final ran = Random();

  AnimationController? controller;
  Animation<Offset>? animation;

  Offset get randomOffset {
    final xValue = ran.nextDouble() * (maxOffset * 2) - maxOffset;
    final yValue = ran.nextDouble() * (maxOffset * 2) - maxOffset;
    return Offset(xValue, yValue);
  }

  void _updateOffset() {
    setState(() {
      offset = animation!.value;
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    animation!.removeListener(_updateOffset);
    super.dispose();
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

    animation!.addListener(_updateOffset);

    widget.onInit(controller!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Transform.translate(
        offset: offset,
        child: widget.child,
      ),
    );
  }
}
