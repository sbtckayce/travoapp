import 'package:flutter/material.dart';

class ButtonImageCamera extends StatelessWidget {
  const ButtonImageCamera({super.key, required this.imageUrl, this.onPressed});
  final ValueNotifier<String> imageUrl;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: imageUrl,
        builder: (context, value, child) {
          return TextButton(
              onPressed: onPressed,
              child: Row(
                children: [
                  const Icon(Icons.camera_alt_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Camera',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ));
        });
  }
}
