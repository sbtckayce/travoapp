import 'package:flutter/material.dart';

import '../animations/slide_animation.dart';
import 'widgets.dart';

class BoxTopAuth extends StatelessWidget {
  const BoxTopAuth({
    super.key, required this.imageUrl, this.isLeading=true,
  });
  final String imageUrl;
  final bool? isLeading ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: Stack(
        children: [
          SlideAnimation(
            child: Image.asset(
              'assets/images/rectangleOval.png',
              width: double.infinity,
              fit: BoxFit.fill
            ),
          ),
        isLeading! ?  const Positioned(
              left: 10, top: 50, child: CustomBackButton()) : const SizedBox(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Image.asset(imageUrl,fit: BoxFit.contain,height: 70,),
            )
          ),
        ],
      ),
    );
  }
}
