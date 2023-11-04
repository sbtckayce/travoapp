import 'package:flutter/material.dart';

import '/widgets/widgets.dart';

import '../screens/select_seat/select_seat_screen.dart';

class ShapeSelectSeatBusiness extends StatelessWidget {
  const ShapeSelectSeatBusiness({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: 170,
            right: 100,
            child: Text(
              'Business',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400),
            )),
        const Positioned(
          top: 190,
          right: 40,
          child: ListGridViewSeatItem(seatType: SeatType.business),
        ),
      ],
    );
  }
}
