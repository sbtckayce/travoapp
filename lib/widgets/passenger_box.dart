import 'package:flutter/material.dart';
import '/widgets/info_passenger.dart';
import '/widgets/passenger_box_inherit.dart';


import '../constants/constants.dart';
import 'widgets.dart';

class PassengerBox extends StatelessWidget {
  const PassengerBox({
    super.key,
    this.onPressed,
  });
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final resultPassenger = PassengerBoxInherit.of(context).resultPassenger;
    return OptionCheckout(
      imageUrl: 'assets/images/seat.png',
      nameOption: 'Passenger & Seats',
      textButton: resultPassenger == null
          ? 'Add Passenger'
          : 'Change Passenger',
      onPressed: onPressed,
      child: resultPassenger != null
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: purpleShade, borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    radius: 20,
                    child: const Icon(Icons.edit_outlined),
                  ),
                  const InfoPassenger()
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
