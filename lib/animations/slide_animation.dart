import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation(
      {super.key,
      this.duration = const Duration(milliseconds: 500),
      this.curve = const Interval(0, 1, curve: Curves.easeIn),
      required this.child,
      this.offsetX = true});

  final Duration duration;
  final Curve curve;

  final Widget child;
  final bool? offsetX;
  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> animation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    Future.delayed(Duration(milliseconds: widget.offsetX! ? 500 : 1000), () {
      if (!mounted) return;
      animationController.forward();
    });
    animation = Tween<Offset>(
            begin: widget.offsetX!
                ? const Offset(5.0, 0.0)
                : const Offset(0.0, -10.0),
            end: Offset.zero)
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
        return SlideTransition(
          position: animation,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
