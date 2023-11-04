import 'package:flutter/material.dart';
import '/localization/app_localization.dart';
import '/validations/validations.dart';

import 'widgets.dart';

class ValidateCardNumber extends StatelessWidget {
  const ValidateCardNumber({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: validations.cardNumber,
        builder: (context, snapshot) {
          return CustomTextField(
             onChanged:    (value) {
              validations.sinkCardNumber.add(value);
            },
            hintText: 'E.g. 4123456789012345',
              suffixIcon: Image.asset(
                'assets/images/visa.png',
              ),
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              title: 'card_number'.tr(context),
              textInputType: TextInputType.phone,
              controller: controller);
        });
  }
}
