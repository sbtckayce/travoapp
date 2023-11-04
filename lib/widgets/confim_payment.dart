import 'package:flutter/material.dart';
import '/widgets/confirm_info_payment_credit.dart';


import '../screens/checkout_hotel/checkout_hotel_screen.dart';
import 'widgets.dart';

class ConfirmPayment extends StatelessWidget {
  const ConfirmPayment({super.key});
  infonConfirmPayment(ValueNotifier<RadioPayment> radioGroupPayment,
      BuildContext context, Object? resultAddCard) {
    switch (radioGroupPayment.value) {
      case RadioPayment.miniMarket:
        return const ConfirmInfoPaymentMini();
      case RadioPayment.credit:
        return ConfirmInfoPaymentCredit(
          resultAddCard: resultAddCard,
        );
      case RadioPayment.bank:
        return const ConfirmInfoPaymentBank();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    final radioGroupPayment =
        RadioCreditInherit.of(context).radioGroupPayment;
    final resultAddCard = RadioCreditInherit.of(context).resultAddCard;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infonConfirmPayment(radioGroupPayment, context, resultAddCard)
      ],
    );
  }
}
