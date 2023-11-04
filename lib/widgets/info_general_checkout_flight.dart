import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/localization/app_localization.dart';
import '/cubits/user/user_cubit.dart';

import '/utils/date_util.dart';
import '/utils/result_flight_item_util.dart';

import 'widgets.dart';

class InfoGeneralCheckoutFlight extends StatefulWidget {
  const InfoGeneralCheckoutFlight({super.key});

  @override
  State<InfoGeneralCheckoutFlight> createState() =>
      _InfoGeneralCheckoutFlightState();
}

class _InfoGeneralCheckoutFlightState extends State<InfoGeneralCheckoutFlight> {

  late UserCubit userCubit;
  @override
  void initState() {
    super.initState();
   
    userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.getInfoUser();
  }

  @override
  Widget build(BuildContext context) {
   final  infoFlightModel = InfoFlightInherit.of(context).infoFlightModel;
    return Positioned.fill(
      top: 110,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ResultFlightItemUtil().showImageFromAirLine(
                        airLine: infoFlightModel.flightModel.airline,
                        width: 50),
                    const SizedBox(
                      width: 10,
                    ),
                    NameDescInfoCheckOutFlightItem(
                        name: 'airline'.tr(context),
                        desc: infoFlightModel.flightModel.airline)
                  ],
                ),
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                   if(state is UserLoading){
                    return const CircleIndicator();
                   }
                   if(state is UserLoaded){
                     return  NameDescInfoCheckOutFlightItem(
                        name: 'passenger'.tr(context), desc: state.userModel.name);
                   }else{
                    return const TextError();
                   }
                  },
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NameDescInfoCheckOutFlightItem(
                    name: 'date'.tr(context),
                    desc: DateUtil().formatDateToMonthDay(
                        infoFlightModel.flightModel.departureTime)),
                NameDescInfoCheckOutFlightItem(
                    name: 'flight_no'.tr(context),
                    desc: infoFlightModel.flightModel.flightNo),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NameDescInfoCheckOutFlightItem(
                    name: 'boarding_time'.tr(context),
                    desc: DateUtil().formatDateToMonthDayYearToHourMinute(
                        infoFlightModel.flightModel.departureTime)),
                NameDescInfoCheckOutFlightItem(
                    name: 'seat'.tr(context), desc: infoFlightModel.seatModel.name),
                NameDescInfoCheckOutFlightItem(
                    name: 'class'.tr(context), desc: infoFlightModel.seatModel.type),
              ],
            )
          ],
        ),
      ),
    );
  }
}
