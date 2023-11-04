import 'package:flutter/material.dart';

import '/utils/date_util.dart';
import '/localization/app_localization.dart';
import '/widgets/check_time_box_inherit.dart';
import '/widgets/type_check.dart';

class CheckTimeItem extends StatelessWidget {
  const CheckTimeItem({super.key, this.isConfirm = false});
  final bool? isConfirm;

  @override
  Widget build(BuildContext context) {
    final checkIn = CheckTimeBoxInherit.of(context).checkIn;
    final checkOut = CheckTimeBoxInherit.of(context).checkOut;
    final chooseCheckIn = CheckTimeBoxInherit.of(context).chooseCheckIn;
    final chooseCheckOut = CheckTimeBoxInherit.of(context).chooseCheckOut;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ValueListenableBuilder(
          valueListenable: checkIn,
          builder: (context, value, child) {
            return Expanded(
              child: TypeCheck(
                  onTap: isConfirm! ? () {} : chooseCheckIn,
                  imageUrl: 'assets/images/checkIn.png',
                  name: 'check_in'.tr(context),
                  date: DateUtil().formatDateToMonthDayYear(checkIn.value)),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: checkOut,
          builder: (context, value, child) {
            return Expanded(
              child: TypeCheck(
                  onTap: isConfirm! ? () {} : chooseCheckOut,
                  imageUrl: 'assets/images/checkOut.png',
                  name: 'check_out'.tr(context),
                  date: DateUtil().formatDateToMonthDayYear(checkOut.value)),
            );
          },
        )
      ],
    );
  }
}
