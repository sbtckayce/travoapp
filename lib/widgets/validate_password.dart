import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../validations/validations.dart';
import 'widgets.dart';

class ValidatePassword extends StatefulWidget {
  const ValidatePassword({super.key, required this.controller, this.onChanged});
  final TextEditingController controller;
  final Function(String value)? onChanged;
  @override
  State<ValidatePassword> createState() => _ValidatePasswordState();
}

class _ValidatePasswordState extends State<ValidatePassword> {
  ValueNotifier<bool> isPassword = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: validations.password,
        builder: (context, snapshot) {
          return ValueListenableBuilder(
            valueListenable: isPassword,
            builder: (context, value, child) {
              return CustomTextField(
                  onChanged: widget.onChanged,
                  obscureText: isPassword.value,
                  title: 'password'.tr(context),
                  controller: widget.controller,
                  errorText:
                      snapshot.hasError ? snapshot.error.toString() : null,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      isPassword.value = !isPassword.value;
                   
                    },
                    child: isPassword.value
                        ? const Icon(Icons.visibility_off_outlined)
                        : const Icon(Icons.visibility_outlined),
                  ));
            },
          );
        });
  }
}
