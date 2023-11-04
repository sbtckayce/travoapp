import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../constants/constants.dart';
import '../widgets/widgets.dart';

class BookingUtil {
  Widget checkActive(
      {required int compareDate,
      required Function()? onTapDelete,
      required BuildContext context}) {
    Color color = Colors.greenAccent;
    String status = 'active'.tr(context);

    switch (compareDate) {
      case 0:
        color = Colors.greenAccent;
        status = 'active'.tr(context);

      case 1:
        color = Colors.greenAccent;
        status = 'active'.tr(context);

      case -1:
        color = redPinkColor;
        status = 'expired'.tr(context);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.brightness_1_rounded,
              color: color,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              status,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        GestureDetector(
          onTap: onTapDelete,
          child: const Icon(
            Icons.delete_outline,
            color: redPinkColor,
          ),
        )
      ],
    );
  }

  showDialogDeleteBookingItem(
      {required BuildContext context, required Function() onSubmit}) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'want_delete_booking'.tr(context),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              const Icon(
                Icons.info_outline,
                color: primaryColor,
              )
            ],
          ),
          content: Text(
            'if_want_delete'.tr(context),
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          actions: [
            CustomButtonDialog(
              onSubmit: onSubmit,
            )
          ],
        );
      },
    );
  }
}
