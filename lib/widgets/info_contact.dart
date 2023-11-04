import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import 'widgets.dart';

class InfoContact extends StatelessWidget {
  const InfoContact({super.key});

  @override
  Widget build(BuildContext context) {
    final resultContact = ContactBoxInherit.of(context).resultContact;
    return resultContact !=null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${'name'.tr(context)} : ${resultContact.guestModel.name}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10,),
              Text(
                '${'email'.tr(context)} : ${resultContact.guestModel.email}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500),
              ),
               const SizedBox(height: 10,),
              Text(
                '${'phone'.tr(context)} : ${resultContact.guestModel.phone}',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.secondary,fontWeight: FontWeight.w500),
              ),
            ],
          )
        : SizedBox(
            child: Text(resultContact.toString()),
          );
  }
}
