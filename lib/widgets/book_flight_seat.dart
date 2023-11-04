import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/constants/constants.dart';
import '/extensions/capital_upper.dart';
import '/widgets/book_flight_inherit.dart';

import '../screens/select_seat/select_seat_screen.dart';
import 'book_flight_box_item.dart';

class BookFlightSeatType extends StatefulWidget {
  const BookFlightSeatType({super.key});

  @override
  State<BookFlightSeatType> createState() => _BookFlightSeatTypeState();
}

class _BookFlightSeatTypeState extends State<BookFlightSeatType> {
  chooseSeatType(ValueNotifier<SeatType> seatType) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
           height: 150,
           padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextButton(
                    style:
                        TextButton.styleFrom(backgroundColor: nostaglaPerfume),
                    onPressed: () {
                      seatType.value = SeatType.business;
                      context.pop();
                    },
                    child: Text(
                      SeatType.business.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    )),
                    const Spacer(),
                TextButton(
                    style:
                        TextButton.styleFrom(backgroundColor: nostaglaPerfume),
                    onPressed: () {
                        seatType.value = SeatType.economy;
                        context.pop();
                    },
                    child: Text(
                      SeatType.economy.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final seatType = BookFlightInherit.of(context).seatType;
    return ValueListenableBuilder(
      valueListenable: seatType,
      builder: (context, value, child) {
        return BookFlightBoxItem(
            onTap: () {
              chooseSeatType(seatType);
            },
            icon: 'assets/images/class.png',
            title: 'class'.tr(context),
            name: seatType.value.name.capitalizeTheFirstLetter());
      },
    );
  }
}
