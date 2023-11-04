import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class ContactBox extends StatelessWidget {
  const ContactBox({
    super.key,
    this.onPressed,
  });
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final resultContact = ContactBoxInherit.of(context).resultContact;
    return OptionCheckout(
      imageUrl: 'assets/images/person.png',
      nameOption: 'contact_details'.tr(context),
      textButton: resultContact == null
          ? 'add_contact'.tr(context)
          : 'change_contact'.tr(context),
      onPressed: onPressed,
      child: resultContact != null
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
                    child:  Icon(Icons.edit_outlined,color: Theme.of(context).colorScheme.secondary,),
                  ),
                  const InfoContact()
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
