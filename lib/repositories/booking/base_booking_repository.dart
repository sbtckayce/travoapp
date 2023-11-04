import 'package:flutter/material.dart';

import '../../models/booking_flight/booking_flight_model.dart';
import '../../models/booking_hotel/booking_hotel_model.dart';
import '../../models/flight/flight_model.dart';

abstract class BaseBookingRepository {
  Future<void> createBookingHotel(
      {required BookingHotelModel bookingHotelModel,
      required BuildContext context});

  Stream<List<BookingHotelModel>> getAllBookingHotel();

  Future<void> deleteBookingHotelWhereUid(
      {required String uid, required BuildContext context});

  Future<void> createBookingFlight(
      {required BookingFlightModel bookingFlightModel,
      required BuildContext context});
  Stream<List<BookingFlightModel>> getAllBookingFlight();

  Future<void> deleteBookingFlightWhereUid(
      {required String uid, required BuildContext context});

  Future<void> updateSeat(
      {required FlightModel flightModel, required BuildContext context});

  Future<void> getFirebaseMessagingToken();

  Future<void> sendPushNotification(
      {required String title,
      required String description,
      required BuildContext context});
}
