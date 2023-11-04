import 'package:flutter/material.dart';

import '../animations/slide_animation.dart';

class BackGroundHeader extends StatelessWidget {
  const BackGroundHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      child: Image.asset(
        'assets/images/rectangleOval.png',
        width: double.infinity,
        height: 150,
        fit: BoxFit.fill,
      ),
    );
  }
}
