import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../utils/date_util.dart';
import 'widgets.dart';

class BookFlightDate extends StatefulWidget {
  const BookFlightDate({
    super.key,
   
  });


  @override
  State<BookFlightDate> createState() => _BookFlightDateState();
}

class _BookFlightDateState extends State<BookFlightDate> {
  chooseDate(ValueNotifier<DateTime> date) async {
    final time = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 50));
    if (time != null) {
     date.value = time;
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = BookFlightInherit.of(context).date;
    return ValueListenableBuilder(
      valueListenable:date,
      builder: (context, value, child) {
        return BookFlightBoxItem(
          icon: 'assets/images/departure.png',
          title: 'departure'.tr(context),
          name: DateUtil().formatDateToMonthDayYear(date.value),
          onTap: () {
            chooseDate(date);
          },
        );
      },
    );
  }
}
