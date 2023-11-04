import 'package:flutter/material.dart';
import '/localization/app_localization.dart';
import '/validations/validations.dart';

import 'widgets.dart';

class ValidateCvv extends StatelessWidget {
  const ValidateCvv({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: validations.cvv,
        builder: (context, snapshot) {
          return CustomTextField(
              hintText: 'E.g. 123',
               onChanged:    (value) {
              validations.sinkCvv.add(value);
            },
              title: 'cvv'.tr(context),
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
              textInputType: TextInputType.number,
              controller: controller);
        });
  }
}
