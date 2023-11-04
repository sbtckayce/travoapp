import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/utils/booking_util.dart';
import '/constants/constants.dart';
import '/cubits/flight/flight_cubit.dart';
import '/repositories/flight/flight_repository.dart';
import '/utils/date_util.dart';
import '/utils/result_flight_item_util.dart';

import 'widgets.dart';

class InfoFlightItem extends StatefulWidget {
  const InfoFlightItem({
    super.key,
    required this.flightId, this.onTapDelete,
  });

  final String flightId;
  final Function()? onTapDelete;
  @override
  State<InfoFlightItem> createState() => _InfoFlightItemState();
}

class _InfoFlightItemState extends State<InfoFlightItem> {
  late FlightCubit flightCubit;
  late FlightRepository flightRepository;
  @override
  void initState() {
    super.initState();

    flightRepository = FlightRepository();

    flightCubit = FlightCubit(flightRepository);

    flightCubit.getFlightWhereFlightId(widget.flightId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightCubit, FlightState>(
        bloc: flightCubit,
        builder: (context, state) {
          if (state is FlightLoading) {
            return const CircleIndicator();
          }
          if (state is FlightLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingUtil().checkActive(
                    compareDate:
                        state.flight.arriveTime.compareTo(DateTime.now()),
                    onTapDelete: widget.onTapDelete,
                    context: context),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'flight'.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'airline'.tr(context)} : ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Container(
                            width: 70,
                            height: 40,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(width: 1, color: primaryColor)),
                            child: ResultFlightItemUtil().showImageFromAirLine(
                                airLine: state.flight.airline, width: 50))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'from'.tr(context)} : ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          state.flight.fromPlace,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'to'.tr(context)} : ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          state.flight.toPlace,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'departure'.tr(context)} : ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          DateUtil().formatDateToMonthDayHourMinute(
                              state.flight.departureTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'arrive'.tr(context)} : ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                        Text(
                          DateUtil().formatDateToMonthDayHourMinute(
                              state.flight.arriveTime),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const TextError();
          }
        });
  }
}
