import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../utils/app_style.dart';
import '../validations/validations.dart';
import 'widgets.dart';

class ValidatePhone extends StatelessWidget {
  const ValidatePhone({super.key, required this.controller, this.onChanged, required this.phoneCode, this.hintText});
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final String phoneCode;
   final String? hintText;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: validations.phone,
      builder: (context, snapshot) {
        return CustomTextField(
          hintText: hintText,
          title: 'phone'.tr(context),
          onChanged: onChanged,
          errorText: snapshot.hasError ? snapshot.error.toString() : null,
          controller: controller,
          textInputType: TextInputType.number,
          prefixIcon: phoneCode.isNotEmpty ? Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: const BoxDecoration(
                  border: Border(
                      right: BorderSide(width: 1, color: Colors.black12))),
              child: Padding(
                padding:
                    EdgeInsets.only(top: snapshot.hasError ? 0 : 10, right: 10),
                child: Text(
                  phoneCode,
                  style: appstyle(14, Theme.of(context).colorScheme.secondary, FontWeight.w500),
                ),
              )): null,
        );
      },
    );
  }
}
