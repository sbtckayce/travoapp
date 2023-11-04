import 'package:flutter/material.dart';
import '/models/card/card_model.dart';

import '../screens/checkout_hotel/checkout_hotel_screen.dart';

class RadioCreditInherit extends InheritedWidget {
  const RadioCreditInherit(
      this.radioGroupPayment, this.resultAddCard, this.onPressed,
      {super.key, required super.child});

  final ValueNotifier<RadioPayment> radioGroupPayment;
  final CardModel? resultAddCard;
  final Function()? onPressed;

  static RadioCreditInherit of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RadioCreditInherit>()!;
  }

  @override
  bool updateShouldNotify(RadioCreditInherit oldWidget) {
    return true;
  }
}
