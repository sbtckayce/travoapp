import 'package:flutter/material.dart';

class TypeCheck extends StatelessWidget {
  const TypeCheck({super.key, required this.imageUrl, required this.name, this.onTap, required this.date});
  final String imageUrl;
  final String name;
  final Function()? onTap;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Image.asset(
            imageUrl,
            width: 32,
          ),
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              date,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500,fontSize: 13),
            )
          ],
        )
      ],
    );
  }
}
