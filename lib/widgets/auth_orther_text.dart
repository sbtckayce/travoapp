import 'package:flutter/material.dart';

class AuthOrtherText extends StatelessWidget {
  const AuthOrtherText({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary),
            width: double.infinity,
            height: 1,
          ),
        ),
        Flexible(
          flex: 4,
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary),
            width: double.infinity,
            height: 1,
          ),
        ),
      ],
    );
  }
}
