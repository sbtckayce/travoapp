import 'package:flutter/material.dart';
import '/localization/app_localization.dart';
import '/validations/validations.dart';

import 'widgets.dart';

class ValidateExpDate extends StatelessWidget {
  const ValidateExpDate({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: validations.expDate,
        builder: (context, snapshot) {
          return CustomTextField(
            onChanged:    (value) {
              validations.sinkExpDate.add(value);
            },
              hintText: 'E.g. 08/23',
              title: 'exp_date'.tr(context),
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              textInputType: TextInputType.datetime,
              controller: controller);
        });
  }
}
