import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/utils/app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.suffixIcon,
      this.obscureText = false,
      this.errorText,
      this.onChanged,
      this.onTap,
      this.hintText,
      this.readOnly = false,
     
      this.prefixIcon,
      this.textInputType = TextInputType.text});
  final String title;

  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final String? errorText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final String? hintText;
  final bool? readOnly;
  final TextInputType? textInputType;
 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: appstyle(14, Theme.of(context).colorScheme.secondary, FontWeight.w400),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TextField(
              
              controller: controller,
              onChanged: onChanged,
              onTap: onTap,
              autofocus: false,
              style: appstyle(14, Theme.of(context).colorScheme.secondary, FontWeight.w500),
              obscureText: obscureText!,
              readOnly: readOnly!,
            
              keyboardType: textInputType,
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: appstyle(14, Theme.of(context).colorScheme.secondary, FontWeight.w300),
                  contentPadding: const EdgeInsets.only(bottom: 8),
                  suffixIcon: suffixIcon,
                  prefixIcon: prefixIcon,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorText: errorText,
                  errorMaxLines: 1,
                  focusColor: primaryColor,
                  focusedErrorBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  errorStyle: appstyle(12, redPinkColor, FontWeight.w400)),
            ),
          )
        ],
      ),
    );
  }
}
