import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class ConfirmInfoPaymentCredit extends StatelessWidget {
  const ConfirmInfoPaymentCredit({super.key, this.resultAddCard});
  final Object? resultAddCard;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onBackground,
          borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        childrenPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        backgroundColor: purpleShade,
        title: Row(
          children: [
            Image.asset(
              'assets/images/credit.png',
              width: 32,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Credit / Debit Card',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                Text(
                  'card info',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.secondary),
                )
              ],
            )
          ],
        ),
        children: [
          resultAddCard != null
              ? const InfoCredit()
              : Row(
                  children: [
                    const Icon(Icons.warning_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'No Infomation',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
