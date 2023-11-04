import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/utils/booking_util.dart';
import '/constants/constants.dart';
import '/cubits/booking/booking_cubit.dart';

import '../models/booking_hotel/booking_hotel_model.dart';

import '/widgets/widgets.dart';

class InfoBookHotelItem extends StatefulWidget {
  const InfoBookHotelItem({super.key, required this.bookingHotelModel});
  final BookingHotelModel bookingHotelModel;

  @override
  State<InfoBookHotelItem> createState() => _InfoBookHotelItemState();
}

class _InfoBookHotelItemState extends State<InfoBookHotelItem> {
  late BookingCubit bookingCubit;
  @override
  void initState() {
    super.initState();
    bookingCubit = BlocProvider.of<BookingCubit>(context);
  }

  onSubmitDelete() {
    context.pop();
    bookingCubit.deleteBookingHotelWhereUid(uid: widget.bookingHotelModel.uid!,context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: nostaglaPerfume, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookingUtil().checkActive(
              compareDate:
                  widget.bookingHotelModel.dateEnd.compareTo(DateTime.now()),
              onTapDelete: () {
                BookingUtil().showDialogDeleteBookingItem(
                  context: context,
                  onSubmit: () {
                    onSubmitDelete();
                  },
                );
              },
              context: context),
          const SizedBox(
            height: 10,
          ),
          Text('\$${widget.bookingHotelModel.price}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary),),
          ExpansionTile(
            tilePadding: const EdgeInsets.all(10),
            childrenPadding: const EdgeInsets.all(10),
            title:
                InfoHotelBookingItem(hotelId: widget.bookingHotelModel.hotelId),
            children: [
              InfoRoomBookingItem(roomId: widget.bookingHotelModel.roomId)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InfoCheckTimeBookingItem(
                  text: 'Check in',
                  image: 'assets/images/checkIn.png',
                  date: widget.bookingHotelModel.dateStart),
              InfoCheckTimeBookingItem(
                  text: 'Check out',
                  image: 'assets/images/checkOut.png',
                  date: widget.bookingHotelModel.dateEnd)
            ],
          )
        ],
      ),
    );
  }
}
