import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class ConfirmContact extends StatelessWidget {
  const ConfirmContact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final resultContact = ContactBoxInherit.of(context).resultContact;
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
            'contact_details'.tr(context),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
          subtitle: Text(
            'contact_info'.tr(context),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.secondary),
          ),
          children: [
            resultContact != null
                ? const InfoContact()
                : Row(
                    children: [
                      const Icon(Icons.warning_outlined),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'no_infomation',
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
