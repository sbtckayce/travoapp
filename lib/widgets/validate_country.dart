import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import 'widgets.dart';

class ValidateCountry extends StatelessWidget {
  const ValidateCountry({super.key, required this.controller, this.onTap});
  final TextEditingController controller;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: 'country'.tr(context),
      readOnly: true,
      controller: controller,
      hintText: controller.text,
      onTap: onTap,
      suffixIcon: const Icon(Icons.keyboard_arrow_down_outlined),
    );
  }
}
