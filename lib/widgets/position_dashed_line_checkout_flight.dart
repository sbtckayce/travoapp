import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

class PositionDashedLineCheckoutFlight extends StatelessWidget {
  const PositionDashedLineCheckoutFlight({super.key, required this.top});
  final double top;
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
                                                top: top,
                                               
                                                child: DottedDashedLine(
                                                    height: 5,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    axis: Axis.horizontal));
  }
}