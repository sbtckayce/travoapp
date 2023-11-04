import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class ConfirmPromo extends StatelessWidget {
  const ConfirmPromo({super.key});

  @override
  Widget build(BuildContext context) {
    final resultPromo = PromoBoxInherit.of(context).resultPromo;
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            borderRadius: BorderRadius.circular(12)),
        child: ExpansionTile(
          backgroundColor: purpleShade,
          childrenPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          title: Text(
            'promo_code'.tr(context),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          subtitle: Text(
            'code'.tr(context),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.secondary),
          ),
          children: [
            resultPromo != null
                ? Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(radius: 20,child: CacheImage(imageUrl: resultPromo.image),),
                      const SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(
                        '${'code'.tr(context)} : ${resultPromo.code}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${'reduce'.tr(context)} : ${resultPromo.price * 100}%',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w600),
                      ),
                      ],)
                    ],
                  )
                : Row(
                    children: [
                      const Icon(Icons.warning_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'no_information'.tr(context),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.secondary),
                      )
                    ],
                  )
          ],
        ));
  }
}
