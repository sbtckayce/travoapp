import 'package:flutter/material.dart';

class CheckTimeBoxInherit extends InheritedWidget {
  const CheckTimeBoxInherit(this.checkIn, this.checkOut, this.chooseCheckIn, this.chooseCheckOut,  {super.key, required super.child});

  final ValueNotifier<DateTime> checkIn;
  final ValueNotifier<DateTime> checkOut;
  
  final Function()? chooseCheckIn;
  final Function()? chooseCheckOut;


  static CheckTimeBoxInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CheckTimeBoxInherit>()!;
  }

  @override
  bool updateShouldNotify(CheckTimeBoxInherit oldWidget) {
    return true;
  }
}
