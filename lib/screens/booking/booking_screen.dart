import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/localization/app_localization.dart';

import '../../cubits/bottom_bar/bottom_bar_cubit.dart';

import '../../widgets/widgets.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  late BottomBarCubit bottomBarCubit;

  @override
  void initState() {
    super.initState();

    bottomBarCubit = BlocProvider.of<BottomBarCubit>(context);
    bottomBarCubit.setPositionPage(2);
  }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHeader(
            title: 'booking_name'.tr(context),
            isLeading: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: ListView(
                children: const [
                  BookingHotelListView(),
                  SizedBox(
                    height: 30,
                  ),
                  BookingFlightListView(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
