

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';

import '/cubits/flight/flight_cubit.dart';
import '/models/search_flight/search_flight.dart';

import '/config/app_router_name.dart';

import '/models/flight/flight_model.dart';

import '../../widgets/widgets.dart';

class ResultFlightScreen extends StatefulWidget {
  const ResultFlightScreen({super.key, required this.searchFlightModel});
  final SearchFlightModel searchFlightModel;
  @override
  State<ResultFlightScreen> createState() => _ResultFlightScreenState();
}

class _ResultFlightScreenState extends State<ResultFlightScreen> {
 

  navigateToSelectSeat(FlightModel flightModel) {
    context.pushNamed(AppRouterName.selectSeat, extra: flightModel);
  }

  late FlightCubit flightCubit;

  @override
  void initState() {
    super.initState();
    flightCubit = BlocProvider.of<FlightCubit>(context);
    flightCubit.getAllFlightWhereInfoFlight(widget.searchFlightModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height - 30,
          child: Stack(
            children: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    const BackGroundHeader(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: CustomBackButton(),
                      ),
                    ),
                    Positioned.fill(
                        child: InfoResultFlight(
                      searchFlightModel: widget.searchFlightModel,
                    )),
                    
                  ],
                ),
              ),
              Positioned.fill(
                top: 120,
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<FlightCubit, FlightState>(
                      builder: (context, state) {
                        if (state is FlightLoading) {
                          return const CircleIndicator();
                        }
                        if (state is FlightListLoaded) {
                          return state.flights.isNotEmpty
                              ? ListView.builder(
                                  itemCount: state.flights.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        navigateToSelectSeat(
                                            state.flights[index]);
                                      },
                                      child: ResultFlightItem(
                                          flightModel: state.flights[index],
                                          index: index,
                                          length: state.flights.length),
                                    );
                                  },
                                )
                              :  NoItem(text: 'no_flight'.tr(context));
                        } else {
                          return const TextError();
                        }
                      },
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
