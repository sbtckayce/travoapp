import 'dart:math';

import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  const ShakeAnimation(
      {super.key,
      this.delay = const Duration(milliseconds: 500),
      this.duration = const Duration(milliseconds: 1000),
      this.curve = const Interval(0, 1, curve: Curves.easeInExpo),
      // Y
      //this.offset = const Offset(0.0, 10.0),
      //X
      this.offset = const Offset(10.0, 0.0),
      this.shake = 10.0,
      required this.child});
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Offset offset;
  final double shake;
  final Widget child;
  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    Future.delayed(widget.delay, () {
      if (!mounted) return;
      animationController.forward();
    });
     animation = Tween<Offset>(begin: widget.offset, end: Offset.zero).animate(
        CurvedAnimation(parent: animationController, curve: widget.curve));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        final sineValue = sin(widget.shake * pi * animationController.value);
        return Transform.translate(
          //Y
          //  offset: Offset(0, sineValue * widget.offset.dy)
             offset: Offset(sineValue * widget.offset.dx, 0)
            ,child: child,);
      },
      child: widget.child,
    );
  }
}
