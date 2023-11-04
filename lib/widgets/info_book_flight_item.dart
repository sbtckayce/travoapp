import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';
import '/utils/date_util.dart';
import '../utils/booking_util.dart';
import '/models/booking_flight/booking_flight_model.dart';
import '/constants/constants.dart';
import '/cubits/booking/booking_cubit.dart';

import '/widgets/widgets.dart';

class InfoBookFlightItem extends StatefulWidget {
  const InfoBookFlightItem({super.key, required this.bookingFlightModel});
  final BookingFlightModel bookingFlightModel;

  @override
  State<InfoBookFlightItem> createState() => _InfoBookFlightItemState();
}

class _InfoBookFlightItemState extends State<InfoBookFlightItem> {
  late BookingCubit bookingCubit;
  @override
  void initState() {
    super.initState();
    bookingCubit = BlocProvider.of<BookingCubit>(context);
  }

  onSubmitDelete() {
    context.pop();
    bookingCubit.deleteBookingFlightWhereUid(uid: widget.bookingFlightModel.uid,context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: purpleShade, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpansionTile(
            tilePadding: const EdgeInsets.all(10),
            childrenPadding: const EdgeInsets.all(10),
            title: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.airline_seat_recline_normal_outlined,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${'seat'.tr(context)} : ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            widget.bookingFlightModel.seatModel.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '- ${widget.bookingFlightModel.seatModel.type}',
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.event_outlined,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        '${'create_at'.tr(context)} : ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        DateUtil().formatDateToMonthDay(
                            widget.bookingFlightModel.createTime),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    '\$${widget.bookingFlightModel.price}',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
            ),
            children: [
              InfoFlightItem(
                onTapDelete: () {
                  BookingUtil().showDialogDeleteBookingItem(
                      context: context,
                      onSubmit: () {
                        onSubmitDelete();
                      });
                },
                flightId: widget.bookingFlightModel.flightId,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
