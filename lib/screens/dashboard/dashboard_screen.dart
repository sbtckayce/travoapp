import 'package:flutter/material.dart';

import '/widgets/widgets.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key, required this.widget});
  final Widget widget;
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.widget,
      bottomNavigationBar: const CustomBottomBar(),
    );
  }
}
