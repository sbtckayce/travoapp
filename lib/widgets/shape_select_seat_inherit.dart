import 'package:flutter/material.dart';



class ShapeSelectSeatInherit extends InheritedWidget {
  const ShapeSelectSeatInherit(this.mapBusinessSeat, this.mapEconomyClassSeat,
      this.currentSeat, this.currentTypeSeat,
      {super.key, required super.child});
  final Map<String,List<bool>> mapBusinessSeat;
  final Map<String,List<bool>> mapEconomyClassSeat;
  final ValueNotifier<String> currentSeat;
  final ValueNotifier<String> currentTypeSeat;
  static ShapeSelectSeatInherit of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ShapeSelectSeatInherit>()!;
  }

  @override
  bool updateShouldNotify(ShapeSelectSeatInherit oldWidget) {
    return true;
  }
}
