import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../screens/checkout_hotel/checkout_hotel_screen.dart';
import 'widgets.dart';

class RadioBank extends StatelessWidget {
  const RadioBank({super.key, required this.radioGroupPayment});
  final ValueNotifier<RadioPayment> radioGroupPayment;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: radioGroupPayment,
      builder: (context, value, child) {
        return TypePayment(
          imageUrl: 'assets/images/bank.png',
          name: 'bank'.tr(context),
          radioValue: RadioPayment.bank,
          radioGroup: radioGroupPayment.value,
          onChanged: (p0) {
            radioGroupPayment.value = p0!;
          },
        );
      },
    );
  }
}
