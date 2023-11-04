import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

import 'widgets.dart';

class InfoBarcodeCheckoutFlight extends StatelessWidget {
  const InfoBarcodeCheckoutFlight({super.key});

  @override
  Widget build(BuildContext context) {
    final infoFlightModel = InfoFlightInherit.of(context).infoFlightModel;
    return Positioned.fill(
        top: 360,
        child: Container(
         
         
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            child: Column(
              children: [
                
                BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: '${infoFlightModel.flightModel.flightNo} ${infoFlightModel.flightModel.departureTime}',
                  height: 90,
                  drawText: true,
                  textPadding:10,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                  errorBuilder: (context, error) => Center(child: Text(error)),
                ),
                
              ],
            )));
  }
}
