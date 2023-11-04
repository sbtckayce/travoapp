import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/constants/constants.dart';

import '../cubits/booking/booking_cubit.dart';
import '../repositories/booking/booking_repository.dart';
import 'widgets.dart';

class BookingFlightListView extends StatefulWidget {
  const BookingFlightListView({super.key});

  @override
  State<BookingFlightListView> createState() => _BookingFlightListViewState();
}

class _BookingFlightListViewState extends State<BookingFlightListView> {
  late BookingCubit bookingFlightCubit;
  late BookingRepository bookingRepository;
  @override
  void initState() {
    super.initState();

    bookingRepository = BookingRepository();
    bookingFlightCubit = BookingCubit(bookingRepository);
    bookingFlightCubit.getAllBookingFlight();
  }

  @override
  Widget build(BuildContext context) {
   
    return BlocBuilder<BookingCubit, BookingState>(
      bloc: bookingFlightCubit,
      builder: (context, state) {
        if (state is BookingLoading) {
          return const CircleIndicator();
        }
        if (state is BookingListFlightLoaded) {
          return state.bookings.isNotEmpty
              ? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.onBackground),
                  child: ExpansionTile(
                    childrenPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'booking_flight'.tr(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: primaryColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.flight_outlined,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ],
                    ),
                    children: [
                      SizedBox(
                        height: 400,
                        child: ListView.builder(
                          itemCount: state.bookings.length,
                          itemBuilder: (context, index) {
                            return InfoBookFlightItem(
                                bookingFlightModel: state.bookings[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : NoItem(text: 'no_booking_flight'.tr(context));
        } else {
          return const TextError();
        }
      },
    );
  }
}
