import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import 'widgets.dart';

class InfoCredit extends StatelessWidget {
  const InfoCredit({super.key});

  @override
  Widget build(BuildContext context) {
    final resultAddCard = RadioCreditInherit.of(context).resultAddCard;
    return resultAddCard != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'name'.tr(context)} : ${resultAddCard.name}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${'card_number'.tr(context)} : ${resultAddCard.cardNumber}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${'exp_date'.tr(context)} : ${resultAddCard.expDate}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${'cvv'.tr(context)} : ${resultAddCard.cvv}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${'country'.tr(context)} : ${resultAddCard.country}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.w500),
              ),
            ],
          )
        : SizedBox(
            child: Text(resultAddCard.toString()),
          );
  }
}
