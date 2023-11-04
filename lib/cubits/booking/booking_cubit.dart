import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/models/booking_flight/booking_flight_model.dart';

import '../../models/booking_hotel/booking_hotel_model.dart';
import '../../models/flight/flight_model.dart';
import '../../repositories/booking/booking_repository.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository _bookingRepository;
  BookingCubit(this._bookingRepository) : super(BookingState());

  createBookingHotel(
      BookingHotelModel bookingHotelModel, BuildContext context) {
    _bookingRepository.createBookingHotel(
        bookingHotelModel: bookingHotelModel, context: context);
  }

  createBookingFlight(
      BookingFlightModel bookingFlightModel, BuildContext context) {
    _bookingRepository.createBookingFlight(
        bookingFlightModel: bookingFlightModel, context: context);
  }

  getAllBookingHotel() {
    emit(BookingLoading());
    _bookingRepository.getAllBookingHotel().listen((event) {
      emit(BookingListHotelLoaded(bookings: event));
    });
  }

  deleteBookingHotelWhereUid( {required String uid,required BuildContext context}) {
    _bookingRepository.deleteBookingHotelWhereUid(uid: uid,context: context);
  }

    getAllBookingFlight() {
    emit(BookingLoading());
    _bookingRepository.getAllBookingFlight().listen((event) {
      emit(BookingListFlightLoaded(bookings: event));
    });
  }

  deleteBookingFlightWhereUid({required String uid,required BuildContext context}) {
    _bookingRepository.deleteBookingFlightWhereUid(uid: uid,context: context);
  }


  updateSeat({required FlightModel flightModel, required BuildContext context}){
    _bookingRepository.updateSeat(flightModel: flightModel,context: context);
  }
  sendPushNotification({required String title, required String description, required BuildContext context}){
    _bookingRepository.sendPushNotification(title: title,description: description,context: context);
  }
}
