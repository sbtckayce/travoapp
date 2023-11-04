import 'package:flutter/material.dart';

import '../utils/date_util.dart';

class InfoCheckTimeBookingItem extends StatelessWidget {
  const InfoCheckTimeBookingItem({super.key, required this.image, required this.date, required this.text});
    final String text;
  final String image;

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  Image.asset(
                    image,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        text,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Text(DateUtil().formatDateToMonthDayYear(date),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary))
                    ],
                  )
                ],
              );
  }
}