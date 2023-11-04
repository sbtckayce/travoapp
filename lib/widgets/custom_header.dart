import 'package:flutter/material.dart';
import '/animations/slide_animation.dart';

import 'widgets.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title, this.isLeading = true});
  final String title;
  final bool? isLeading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          const BackGroundHeader(),
          isLeading!
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CustomBackButton(),
                  ),
                )
              : const SizedBox(),
          Align(
            alignment: Alignment.center,
            child: SlideAnimation(
              offsetX: false,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 30, height: 1.3),
              ),
            ),
          )
        ],
      ),
    );
  }
}
