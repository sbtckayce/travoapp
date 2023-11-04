import 'package:flutter/material.dart';
import '/extensions/capital_upper.dart';
import '/models/search_flight/search_flight.dart';
import '/utils/date_util.dart';

class InfoResultFlight extends StatelessWidget {
  const InfoResultFlight({super.key, required this.searchFlightModel});
  final SearchFlightModel searchFlightModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              searchFlightModel.fromPlace,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 30,
              height: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(
              width: 5,
            ),
            Image.asset(
              'assets/images/planeLine.png',
              width: 24,
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 30,
              height: 1,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              searchFlightModel.toPlace,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateUtil().formatDateToMonthDayYear(searchFlightModel.date),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${searchFlightModel.numberPassenger} Adult',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              searchFlightModel.seatType.capitalizeTheFirstLetter(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ],
    );
  }
}
