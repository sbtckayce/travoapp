import 'package:flutter/material.dart';

import 'widgets.dart';

class AllInfoGeneralCheckouFlight extends StatelessWidget {
  const AllInfoGeneralCheckouFlight({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        InfoFromToCheckoutFlight(),
        PositionDashedLineCheckoutFlight(top: 90),
        PositionCircleTransparentLeft(
          top: 76,
          left: -15,
        ),
        PositionCircleTransparentRight(
          top: 76,
          right: -15,
        ),
        InfoGeneralCheckoutFlight(),
        PositionDashedLineCheckoutFlight(top: 350),
        PositionCircleTransparentLeft(
          top: 336,
          left: -15,
        ),
        PositionCircleTransparentRight(
          top: 336,
          right: -15,
        ),
      ],
    );
  }
}
