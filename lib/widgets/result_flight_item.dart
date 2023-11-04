import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '/utils/date_util.dart';
import '/utils/result_flight_item_util.dart';
import '/constants/constants.dart';
import '/models/flight/flight_model.dart';

class ResultFlightItem extends StatefulWidget {
  const ResultFlightItem(
      {super.key,
      required this.flightModel,
      required this.index,
      required this.length});
  final FlightModel flightModel;
  final int index;
  final int length;

  @override
  State<ResultFlightItem> createState() => _ResultFlightItemState();
}

class _ResultFlightItemState extends State<ResultFlightItem> {
 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 170,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.onBackground),
          child: Row(
            children: [
              ResultFlightItemUtil().showImageFromAirLine(airLine: widget.flightModel.airline ,width: 75),
              const SizedBox(
                width: 20,
              ),
              const DottedDashedLine(
                  height: 120, width: 1, axis: Axis.vertical),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'departure'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                    fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          'arrive'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: 14,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        )
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateUtil().formatDateToMonthDay(
                                  widget.flightModel.departureTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateUtil().formatDateToMonthDayYearToHourMinute(
                                  widget.flightModel.departureTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateUtil().formatDateToMonthDay(
                                  widget.flightModel.arriveTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              DateUtil().formatDateToMonthDayYearToHourMinute(
                                  widget.flightModel.arriveTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'flight_no'.tr(context),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 13,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.flightModel.flightNo,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '\$${widget.flightModel.price}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
            top: -10,
            left: 105,
            child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  widget.index == 0 ? primaryColor : scafoldColorLight,
            )),
        widget.index == widget.length - 1
            ? const SizedBox()
            : const Positioned(
                bottom: 10,
                left: 105,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: scafoldColorLight,
                )),
      ],
    );
  }
}
