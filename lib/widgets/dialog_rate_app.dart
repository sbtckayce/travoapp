import 'package:flutter/material.dart';


import '../constants/constants.dart';
import '/localization/app_localization.dart';


import '/widgets/widgets.dart';

class DialogRateApp extends StatelessWidget {
  const DialogRateApp({super.key, this.onSubmit});
  final Function()? onSubmit;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.onBackground),
          child: Image.asset(
            'assets/images/icon_dev.png',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'enjoying'.tr(context),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500),
          ),
          Text(
            'by_team'.tr(context),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500),
          ),
          Text(
            'tap_star'.tr(context),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          Text(
            'App Store.',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const Divider(
            thickness: 1,
          ),
          RatingBarBox(
            itemSize: 25,
            color: primaryColor,
            initRating: 3,
            onRatingUpdate: (p0) {
             
            },
          ),
          const Divider(
            thickness: 1,
          ),
          Text(
            'choose_submit'.tr(context),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
      actions: [
       CustomButtonDialog(onSubmit: onSubmit,)
      ],
    );
  }
}
