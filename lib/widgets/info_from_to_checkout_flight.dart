import 'package:flutter/material.dart';
import '/widgets/info_flight_inherit.dart';

class InfoFromToCheckoutFlight extends StatelessWidget {
  const InfoFromToCheckoutFlight({super.key});

  @override
  Widget build(BuildContext context) {
    final infoFlightModel = InfoFlightInherit.of(context).infoFlightModel;
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              infoFlightModel.flightModel.fromPlace,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24, color: Theme.of(context).colorScheme.secondary),
            ),
            const Spacer(),
            Container(
              width: 20,
              height: 1,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/planeCheckout.png',
              width: 24,
            ),
            const Spacer(),
            Container(
              width: 20,
              height: 1,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.secondary),
            ),
           const Spacer(),
            Text(
              infoFlightModel.flightModel.toPlace,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 24, color: Theme.of(context).colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
