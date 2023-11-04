import 'package:flutter/material.dart';

import '/widgets/widgets.dart';

import '../screens/select_seat/select_seat_screen.dart';

class ShapeSelectSeatEconomy extends StatelessWidget {
  const ShapeSelectSeatEconomy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 340,
            right: 85,
            child: Text(
              'Economy Class',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400),
            )),
        const Positioned(
          top: 360,
          right: 20,
          child: ListGridViewSeatItem(seatType: SeatType.economy),
        ),
      ],
    );
  }
}
