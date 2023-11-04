import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PositionCircleTransparentLeft extends StatelessWidget {
  const PositionCircleTransparentLeft(
      {super.key, required this.top, required this.left,});
  final double top;
  final double left;
 
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: top,
        left: left,
      
        child: const CircleAvatar(
          radius: 15,
          backgroundColor: scafoldColorLight,
        ));
  }
}
