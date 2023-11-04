import 'package:flutter/material.dart';
import '/utils/app_style.dart';

class OnBoardingItem extends StatelessWidget {
  const OnBoardingItem(
      {super.key,
      required this.image,
      required this.title,
      required this.description, required this.index});
  final String image;
  final String title;
  final String description;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 102,
        ),
        Flexible(
          flex: 7,
          child: Padding(
            padding: index == 0 ?const EdgeInsets.only(left: 75) : index ==1 ? EdgeInsets.zero : const EdgeInsets.only(right: 75),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
              width: 375,
            ),
          ) 
        ),
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(title, style: appstyle(24, Colors.black, FontWeight.w500)),
              const Spacer(),
              Text(
                description,
                style: appstyle(14, Colors.black, FontWeight.w400),
              ),
               const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
