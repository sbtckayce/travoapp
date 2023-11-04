import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ButtonAddOptionCheckout extends StatelessWidget {
  const ButtonAddOptionCheckout({super.key, required this.textButton, this.onPressed});
  final String textButton;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: purpleShade,
                  padding: EdgeInsets.zero,
                  maximumSize: const Size(200, 50)),
              onPressed: onPressed,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                   CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.onBackground,
                      radius: 20,
                      child: Icon(Icons.add_rounded,color: Theme.of(context).colorScheme.secondary,),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      textButton,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ));
  }
}