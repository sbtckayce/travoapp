import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation(
      {super.key,
      this.duration = const Duration(milliseconds: 1500),
      this.delay = const Duration(milliseconds: 500),
      this.curve = const Interval(0, 1, curve: Curves.easeOut),
      this.begin = 0.0,
      this.end = 1.0,
      required this.child});
  final Duration duration;
  final Duration delay;
  final Curve curve;
  final double begin;
  final double end;
  final Widget child;
  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    Future.delayed(widget.delay, () {
      if (!mounted) return;
      animationController.forward();
    });
    animation = Tween<double>(begin: widget.begin, end: widget.end).animate(
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
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
