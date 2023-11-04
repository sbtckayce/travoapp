import 'package:flutter/material.dart';

class BoxFilterFlight extends StatelessWidget {
  const BoxFilterFlight(
      {super.key,
      required this.imageUrl,
      required this.text,
      this.onTap,
    required  this.child});
  final String imageUrl;
  final String text;
  final Function()? onTap;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onBackground,
      ),
      child: ExpansionTile(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        title: Row(
          children: [
            GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  imageUrl,
                  width: 32,
                )),
            const SizedBox(
              width: 20,
            ),
            Text(text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary))
          ],
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [child],
          )
        ],
      ),
    );
  }
}
