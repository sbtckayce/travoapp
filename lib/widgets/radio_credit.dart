import 'package:flutter/material.dart';
import '/localization/app_localization.dart';


import '../constants/constants.dart';
import '../screens/checkout_hotel/checkout_hotel_screen.dart';
import 'widgets.dart';

class RadioCredit extends StatelessWidget {
  const RadioCredit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final radioGroupPayment =
        RadioCreditInherit.of(context).radioGroupPayment;
    final resultAddCard = RadioCreditInherit.of(context).resultAddCard;
    final onPressed = RadioCreditInherit.of(context).onPressed;
    return ValueListenableBuilder(
      valueListenable: radioGroupPayment,
      builder: (context, value, child) {
        return TypePayment(
          imageUrl: 'assets/images/credit.png',
          name: 'credit'.tr(context),
          radioValue: RadioPayment.credit,
          radioGroup: radioGroupPayment.value,
          onChanged: (p0) {
            radioGroupPayment.value = p0!;
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                resultAddCard != null
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                           color: nostaglaPerfume,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onBackground,
                              radius: 20,
                              child:  Icon(Icons.edit_outlined,color:  Theme.of(context).colorScheme.secondary,),
                            ),
                            const InfoCredit()
                          ],
                        ),
                      )
                    : const SizedBox(),
                ButtonAddOptionCheckout(
                  textButton: resultAddCard == null ? 'add_card'.tr(context) : 'change_card'.tr(context),
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
