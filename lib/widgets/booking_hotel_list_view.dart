import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/constants/constants.dart';

import '../cubits/booking/booking_cubit.dart';
import 'widgets.dart';

class BookingHotelListView extends StatefulWidget {
  const BookingHotelListView({super.key});

  @override
  State<BookingHotelListView> createState() => _BookingHotelListViewState();
}

class _BookingHotelListViewState extends State<BookingHotelListView> {
  late BookingCubit bookingHotelCubit;
  @override
  void initState() {
    super.initState();
    bookingHotelCubit = BlocProvider.of<BookingCubit>(context);
    bookingHotelCubit.getAllBookingHotel();
  }

  @override
  Widget build(BuildContext context) {
 

    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        if (state is BookingLoading) {
          return const CircleIndicator();
        }
        if (state is BookingListHotelLoaded) {
          return state.bookings.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.onBackground),
                  child: ExpansionTile(
                    childrenPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    title: Row(
                      children: [
                        Text(
                          'booking_hotel'.tr(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: primaryColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.hotel_outlined,
                          color: primaryColor,
                        )
                      ],
                    ),
                    children: [
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: state.bookings.length,
                          itemBuilder: (context, index) {
                            return InfoBookHotelItem(
                                bookingHotelModel: state.bookings[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : NoItem(text: 'no_booking_hotel'.tr(context));
        } else {
          return const TextError();
        }
      },
    );
  }
}
