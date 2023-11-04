import 'package:flutter/material.dart';
import '/utils/app_style.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton(
      {super.key,
      required this.imageUrl,
      required this.text,
      required this.colorText,
      required this.colorButton,
      this.onPressed});
  final String imageUrl;
  final String text;
  final Color colorText;
  final Color colorButton;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            backgroundColor: colorButton,
            minimumSize: const Size(170, 40),
             ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 15,),
            Text(text, style: appstyle(15, colorText, FontWeight.w500))
          ],
        ));
  }
}
