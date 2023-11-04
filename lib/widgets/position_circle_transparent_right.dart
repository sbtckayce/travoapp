import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PositionCircleTransparentRight extends StatelessWidget {
  const PositionCircleTransparentRight(
      {super.key, required this.top, required this.right});
  final double top;
  final double right;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        right: right,
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: scafoldColorLight,
        ));
  }
}
