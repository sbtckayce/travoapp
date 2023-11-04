import 'package:flutter/material.dart';
import '/models/flight/flight_model.dart';

import '../constants/constants.dart';

class InfoFromToSelectSeat extends StatelessWidget {
  const InfoFromToSelectSeat({super.key, required this.flightModel});
  final FlightModel flightModel;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              flightModel.fromPlace,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 20, color: primaryColor),
            ),
            const SizedBox(height: 20,),
            Image.asset(
              'assets/images/planeFromTo.png',
              width: 24,
            ),
               const SizedBox(height: 20,),
            Text(
              flightModel.toPlace,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontSize: 20, color: primaryColor),
            )
          ],
        ));
  }
}
