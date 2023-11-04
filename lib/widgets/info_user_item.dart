import 'package:flutter/material.dart';

class InfoUserItem extends StatelessWidget {
  const InfoUserItem({
    super.key, required this.title, required this.description,
  });
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w400),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary),
        )
      ],
    );
  }
}