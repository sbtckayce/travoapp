import 'package:flutter/material.dart';
import '/models/info_flight/info_flight.dart';

class InfoFlightInherit extends InheritedWidget {
  const InfoFlightInherit(this.infoFlightModel,  {super.key, required super.child});

 
  final InfoFlightModel infoFlightModel;


  static InfoFlightInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InfoFlightInherit>()!;
  }

  @override
  bool updateShouldNotify(InfoFlightInherit oldWidget) {
    return true;
  }
}
