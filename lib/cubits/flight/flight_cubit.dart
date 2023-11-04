import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/flight/flight_model.dart';
import '/models/search_flight/search_flight.dart';
import '/repositories/flight/flight_repository.dart';

part 'flight_state.dart';

class FlightCubit extends Cubit<FlightState> {
  final FlightRepository _flightRepository;
  FlightCubit(FlightRepository flightRepository)
      : _flightRepository = flightRepository,
        super(FlightLoading());

  getAllFlight() {
    emit(FlightLoading());
    _flightRepository.getAllFlight().listen((event) {
      emit(FlightListLoaded(flights: event));
    });
  }

  getFlightWhereFlightId(String flightId) {
    emit(FlightLoading());
    _flightRepository.getFlightWhereFlightId(flightId).listen((event) {
      emit(FlightLoaded(flight: event));
    });
  }

  getAllFlightWhereInfoFlight(SearchFlightModel searchFlightModel) {
    emit(FlightLoading());
    _flightRepository
        .getAllFightWhereInfoFlight(searchFlightModel)
        .listen((event) {
      emit(FlightListLoaded(flights: event));
    });
  }

  createFlight(
      {required FlightModel flightModel, required BuildContext context}) {
    _flightRepository.createFlight(flightModel: flightModel, context: context);
  }

  deleteFlight({required String id, required BuildContext context}) {
    _flightRepository.deleteFlight(id: id, context: context);
  }
}
