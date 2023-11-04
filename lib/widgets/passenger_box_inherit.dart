import 'package:flutter/material.dart';

import '../models/passenger/passenger_model.dart';

class PassengerBoxInherit extends InheritedWidget {
  const PassengerBoxInherit(this. resultPassenger,  {super.key, required super.child});

  final PassengerModel? resultPassenger;

  static PassengerBoxInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PassengerBoxInherit>()!;
  }

  @override
  bool updateShouldNotify(PassengerBoxInherit oldWidget) {
    return true;
  }
}
