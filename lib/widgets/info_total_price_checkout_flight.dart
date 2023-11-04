import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/localization/app_localization.dart';
import '/models/flight/flight_model.dart';

import 'promo_box_inherit.dart';

class InfoTotalPriceCheckoutFlight extends StatelessWidget {
  const InfoTotalPriceCheckoutFlight(
      {super.key,
      required this.flightModel,
      required this.taxes,
      required this.total});
  final FlightModel flightModel;
  final String taxes;
  final double total;

  @override
  Widget build(BuildContext context) {
    final resultPromo = PromoBoxInherit.of(context).resultPromo;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: nostaglaPerfume),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'if_night_price_150'.tr(context),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(
            height: 10,
          ),
          DottedDashedLine(
              height: 5,
              width: MediaQuery.of(context).size.width,
              axis: Axis.horizontal),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1_passenger'.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                '\$${flightModel.price}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'taxes'.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                taxes,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          resultPromo != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'insurance'.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    Text(
                      '${resultPromo.price * 100}%',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'insurance'.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'no_information'.tr(context),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
          const SizedBox(
            height: 10,
          ),
          DottedDashedLine(
              height: 5,
              width: MediaQuery.of(context).size.width,
              axis: Axis.horizontal),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'total'.tr(context),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary),
              ),
              Text(
                '\$$total',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ),
        ],
      ),
    );
  }
}
