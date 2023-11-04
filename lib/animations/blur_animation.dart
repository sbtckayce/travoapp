import 'dart:ui';

import 'package:flutter/material.dart';

class BlurAnimation extends StatefulWidget {
  const BlurAnimation(
      {super.key,
      this.delay = const Duration(milliseconds: 500),
      this.duration = const Duration(milliseconds: 500),
      this.curve = const Interval(0, 1, curve: Curves.easeInBack),
      this.initOffset = const Offset(4.0, 4.0),
      this.finalOffset = const Offset(0.0, 0.0),
      required this.child});
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final Offset initOffset;
  final Offset finalOffset;
  final Widget child;
  @override
  State<BlurAnimation> createState() => _BlurAnimationState();
}

class _BlurAnimationState extends State<BlurAnimation>
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
    animation = Tween<Offset>(begin: widget.initOffset, end: widget.finalOffset)
        .animate(
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
        final double sigmaX = animation.value.dx;
        final double sigmaY = animation.value.dy;
        return ImageFiltered(
          imageFilter: ImageFilter.blur(
              sigmaX: sigmaX, sigmaY: sigmaY, tileMode: TileMode.decal),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
