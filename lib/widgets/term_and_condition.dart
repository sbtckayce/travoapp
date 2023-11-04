import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: RichText(
          maxLines: 2,
          textAlign: TextAlign.center,
          text: TextSpan(children: const [
            TextSpan(text: 'By tapping sign up you agree to the '),
            TextSpan(
                text: ' Terms and Condition ',
                style: TextStyle(color: primaryColor)),
            TextSpan(text: 'and'),
            TextSpan(
                text: ' Privacy Policy', style: TextStyle(color: primaryColor)),
            TextSpan(text: ' of this app')
          ], style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary))),
    );
  }
}
