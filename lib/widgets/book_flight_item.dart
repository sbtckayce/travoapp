import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '/widgets/widgets.dart';


import 'book_flight_from_to.dart';

class BookFlightItem extends StatefulWidget {
  const BookFlightItem({
    super.key,
    this.isReturn = false,
  });
  final bool? isReturn;

  @override
  State<BookFlightItem> createState() => _BookFlightItemState();
}

class _BookFlightItemState extends State<BookFlightItem> {
 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BookFlightFromTo(),
        const BookFlightDate(),
        widget.isReturn!
            ?  BookFlightBoxItem(
                icon: 'assets/images/departure.png',
                title: 'return'.tr(context),
                name: 'Select Date')
            : const SizedBox(),
        BookFlightBoxItem(
            icon: 'assets/images/passenger.png',
            title: 'passenger'.tr(context),
            name: '1_passenger'.tr(context)),
       const BookFlightSeatType()
      ],
    );
  }
}
