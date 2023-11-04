import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utils/app_style.dart';

class NoItem extends StatelessWidget {
  const NoItem({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text,style: appstyle(15, primaryColor, FontWeight.w500),));
  }
}