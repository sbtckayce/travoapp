import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class PromoCodeBox extends StatelessWidget {
  const PromoCodeBox({
    super.key,
    this.onPressed,
  });
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final resultPromo = PromoBoxInherit.of(context).resultPromo;
    return OptionCheckout(
      imageUrl: 'assets/images/promo.png',
      nameOption: 'promo_code'.tr(context),
      textButton: resultPromo == null
          ? 'add_promo_code'.tr(context)
          : 'change_promo_code'.tr(context),
      onPressed: onPressed,
      child: resultPromo != null
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: nostaglaPerfume,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    radius: 20,
                    child: const Icon(Icons.edit_outlined),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'code'.tr(context)} : ${resultPromo.code}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(
                         '${'reduce'.tr(context)} : ${resultPromo.price * 100}%',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
