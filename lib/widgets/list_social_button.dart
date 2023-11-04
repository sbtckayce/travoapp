
import 'package:flutter/material.dart';

import 'widgets.dart';

class ListSocialButton extends StatelessWidget {
  const ListSocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomSocialButton(
          imageUrl: 'assets/images/google.png',
          text: 'Google',
          colorText: Colors.black,
          colorButton: Theme.of(context).colorScheme.onBackground,
          onPressed: () {},
        ),
        CustomSocialButton(
          imageUrl: 'assets/images/facebook.png',
          text: 'Facebook',
          colorText: Theme.of(context).colorScheme.onBackground,
          colorButton: const Color(0xFF3C5C9A),
          onPressed: () {},
        )
      ],
    );
  }
}
