import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../validations/validations.dart';
import 'widgets.dart';

class ValidateEmail extends StatelessWidget {
  const ValidateEmail({super.key, required this.controller, this.onChanged, this.hintText});

  final TextEditingController controller;
  final Function(String value)? onChanged;
  final String? hintText;
  @override
  Widget build(BuildContext context) {
    return 
        StreamBuilder(
          stream: validations.email,
          builder: (context, snapshot) {
            return CustomTextField(
              hintText: hintText,
              onChanged: onChanged,
              title: 'email'.tr(context),
              controller: controller,
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
            );
          },
        
     
    );
  }
}
