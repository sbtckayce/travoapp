import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import 'info_flight_inherit.dart';

class InfoPriceQuantityCheckoutFlight extends StatelessWidget {
  const InfoPriceQuantityCheckoutFlight({super.key});

  @override
  Widget build(BuildContext context) {
     final infoFlightModel = InfoFlightInherit.of(context).infoFlightModel;
    return Positioned.fill(
        top: 360,
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '\$${infoFlightModel.flightModel.price} /',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  const SizedBox(width: 3,),
                  Text(
                    'passenger'.tr(context),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              Text(
                '1_passenger'.tr(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ],
          ),
        ));
  }
}
