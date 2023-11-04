import 'package:flutter/material.dart';
import '/localization/app_localization.dart';



import '../validations/validations.dart';
import 'widgets.dart';

class ValidateName extends StatelessWidget {
  const ValidateName({super.key, required this.controller, this.onChanged, this.hintText});

  final TextEditingController controller;
  final Function(String value)? onChanged;
   final String? hintText;
  @override
  Widget build(BuildContext context) {
    return 
        StreamBuilder(
          stream: validations.name,
          builder: (context, snapshot) {
            return CustomTextField(
              onChanged: onChanged,
              hintText: hintText,
              title: 'name'.tr(context),
              controller: controller,
              errorText: snapshot.hasError ? snapshot.error.toString() : null,
            );
          },
        
     
    );
  }
}
