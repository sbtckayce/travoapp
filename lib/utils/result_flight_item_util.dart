import 'package:flutter/material.dart';

import '../animations/fade_animation.dart';

class ResultFlightItemUtil{

   Widget showImageFromAirLine({required String airLine,required double width}) {
    String image = '';
    switch (airLine) {
      case 'AirAsia':
        image = 'assets/images/airAsia.png';
      case 'LionAir':
        image = 'assets/images/lionAir.png';
      case 'Citilink':
        image = 'assets/images/citiLink.png';
      case 'BatikAir':
        image = 'assets/images/batik.png';
      case 'Garuna':
        image = 'assets/images/garuda.png';
      default:
        image = 'assets/images/airAsia.png';
    }
    return FadeAnimation(
      child: Image.asset(
        image,
        width: width,
        fit: BoxFit.contain,
      ),
    );
  }
}