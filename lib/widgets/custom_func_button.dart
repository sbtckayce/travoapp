import 'package:flutter/material.dart';


import '../animations/fade_animation.dart';


class CustomFuncButton extends StatelessWidget {
  const CustomFuncButton({super.key, this.onPressed, required this.icon,});
    final Function()? onPressed;
    final Widget icon;
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: TextButton(
        style: TextButton.styleFrom(
         
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            
          ),
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          minimumSize: const Size(25, 25),
          
        ),
        onPressed: onPressed, child:icon,),
    );
  }
}