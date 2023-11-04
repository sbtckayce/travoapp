import 'package:flutter/material.dart';
import '/utils/app_style.dart';

class TransitItem extends StatelessWidget {
  const TransitItem(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.colorText});
  final Color backgroundColor;
  final String text;
  final Color colorText;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            text,
            style: appstyle(14, colorText, FontWeight.w400),
          ),
        ));
  }
}
