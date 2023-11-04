import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/utils/app_style.dart';

class TextError extends StatelessWidget {
  const TextError({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Something went wrong !',
      style: appstyle(20, primaryColor, FontWeight.w500),
    );
  }
}
