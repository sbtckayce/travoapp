import 'package:flutter/material.dart';


class ButtonImageGallery extends StatelessWidget {
  const ButtonImageGallery({super.key, required this.imageUrl, this.onPressed});
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
                  const Icon(Icons.camera_outlined),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )
                ],
              ));
        });
  }
}
