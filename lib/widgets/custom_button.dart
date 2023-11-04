import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';
import '/constants/constants.dart';
import '/utils/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.colorText = Colors.white,
      this.onPressed,
      this.size,
      this.backgroundColor = primaryColor});
  final String text;
  final Color colorText;
  final Size? size;
  final Function()? onPressed;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: backgroundColor,
            
            minimumSize: size,
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: appstyle(15, colorText, FontWeight.normal),
          )),
    );
  }
}
