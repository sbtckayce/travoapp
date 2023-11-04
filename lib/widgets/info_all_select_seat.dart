import 'package:flutter/material.dart';
import '/localization/app_localization.dart';
import '/models/flight/flight_model.dart';
import '/widgets/widgets.dart';

import '../constants/constants.dart';
import '../utils/app_style.dart';

class InfoAllSelectSeat extends StatelessWidget {
  const InfoAllSelectSeat(
      {super.key, required this.currentSeat, required this.currentTypeSeat, required this.flightModel});
  final ValueNotifier<String> currentSeat;
  final ValueNotifier<String> currentTypeSeat;
  final FlightModel flightModel;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
           Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/seat.png',
                            width: 32,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                'seat'.tr(context),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                              ),
                              ValueListenableBuilder(
                                valueListenable: currentSeat,
                                builder: (context, value, child) {
                                  return Text(
                                    currentSeat.value,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                            fontSize: 24, color: primaryColor),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                      ValueListenableBuilder(
                        valueListenable: currentTypeSeat,
                        builder: (context, value, child) {
                          return Text(
                            currentTypeSeat.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: nostaglaPerfume,
                        ),
                        child: Center(
                            child: Text(
                          '\$${flightModel.price}',
                          style: appstyle(16, primaryColor, FontWeight.w500),
                        )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
           InfoFromToSelectSeat(flightModel: flightModel,)
        ],
      ),
    );
  }
}
