import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/animations/fade_animation.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key,});
  
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
        onPressed: (){
          context.pop();
        }, child:const Icon(Icons.arrow_back_ios,)),
    );
  }
}