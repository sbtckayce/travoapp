import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import 'widgets.dart';

class CheckTimeBox extends StatelessWidget {
  const CheckTimeBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).colorScheme.onBackground),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'booking_date'.tr(context),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 15,
          ),
          const CheckTimeItem()
        ],
      ),
    );
  }
}
