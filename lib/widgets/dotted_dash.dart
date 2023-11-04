import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

class DottedDash extends StatelessWidget {
  const DottedDash({super.key});

  @override
  Widget build(BuildContext context) {
    return const DottedDashedLine(
        height: 5, width: double.infinity, axis: Axis.horizontal);
  }
}
