import 'package:flutter/material.dart';
import '/constants/constants.dart';

import '../screens/checkout_hotel/checkout_hotel_screen.dart';

class TypePayment extends StatefulWidget {
  const TypePayment(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.radioValue,
      this.child,
      this.onChanged,
      required this.radioGroup});
  final String imageUrl;
  final String name;
  final RadioPayment radioValue;
  final RadioPayment radioGroup;
  final Widget? child;
  final Function(RadioPayment?)? onChanged;
  @override
  State<TypePayment> createState() => _TypePaymentState();
}

class _TypePaymentState extends State<TypePayment> {

  ValueNotifier<RadioPayment> radioGroup =
      ValueNotifier(RadioPayment.miniMarket);
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
            Row(
              children: [
                Image.asset(
                  widget.imageUrl,
                  width: 32,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Text(
                    widget.name,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                
                Radio(
                    groupValue: widget.radioGroup,
                    value: widget.radioValue,
                    activeColor: primaryColor,
                    
                    onChanged: widget.onChanged),
              ],
            ),
            SizedBox(
              child: widget.child,
            )
          ],
        ));
  }
}
