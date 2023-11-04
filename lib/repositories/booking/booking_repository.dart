import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:http/http.dart' as http;
import '/models/booking_flight/booking_flight_model.dart';

import '../../models/flight/flight_model.dart';

import 'base_booking_repository.dart';
import '../../models/booking_hotel/booking_hotel_model.dart';
import '../../utils/show_message_util.dart';
import '/utils/variable_const.dart';

import '../../config/app_router_name.dart';

class BookingRepository extends BaseBookingRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _firebaseMessaging;
  BookingRepository(
      {FirebaseFirestore? firebaseFirestore,
      FirebaseAuth? firebaseAuth,
      FirebaseMessaging? firebaseMessaging})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  @override
  Future<void> createBookingHotel(
      {required BookingHotelModel bookingHotelModel,
      required BuildContext context}) async {
    try {
      showLoadingDialog(context, 'Booking hotel');
      await _firebaseFirestore
          .collection(VariableConst.bookingHotelCollection)
          .add(bookingHotelModel.toMap());
      if (context.mounted) context.goNamed(AppRouterName.home);
    } catch (e) {
      Navigator.pop(context);
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> createBookingFlight(
      {required BookingFlightModel bookingFlightModel,
      required BuildContext context}) async {
    try {
      showLoadingDialog(context, 'Booking flight');
      await _firebaseFirestore
          .collection(VariableConst.bookingFlightCollection)
          .add(bookingFlightModel.toMap());
      if (context.mounted) context.goNamed(AppRouterName.home);
    } catch (e) {
      Navigator.pop(context);
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Stream<List<BookingHotelModel>> getAllBookingHotel() {
    try {
      String? email = _firebaseAuth.currentUser!.email;
      return _firebaseFirestore
          .collection(VariableConst.bookingHotelCollection)
          .where('email', isEqualTo: email)
          .snapshots()
          .map((event) {
        List<BookingHotelModel> list = [];
        for (var doc in event.docs) {
          list.add(BookingHotelModel.fromMap(doc.reference.id, doc.data()));
        }

        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBookingHotelWhereUid(
      {required String uid, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.bookingHotelCollection)
          .doc(uid)
          .delete();
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> updateSeat(
      {required FlightModel flightModel, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.flightCollection)
          .doc(flightModel.uid)
          .set(flightModel.toMap());
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> deleteBookingFlightWhereUid(
      {required String uid, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.bookingFlightCollection)
          .doc(uid)
          .delete();
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Stream<List<BookingFlightModel>> getAllBookingFlight() {
    try {
      String? email = _firebaseAuth.currentUser!.email;
      return _firebaseFirestore
          .collection(VariableConst.bookingFlightCollection)
          .where('email', isEqualTo: email)
          .snapshots()
          .map((event) {
        List<BookingFlightModel> list = [];
        for (var doc in event.docs) {
          list.add(BookingFlightModel.fromMap(doc.reference.id, doc.data()));
        }

        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> getFirebaseMessagingToken() async {
    await _firebaseMessaging.requestPermission();
    await _firebaseMessaging.getToken().then((value) {
      if (value != null) {
        log('token $value');
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  Future<void> sendPushNotification(
      {required String title,
      required String description,
      required BuildContext context}) async {
    try {
      var token =
          'fnMyiowuRCSIhtMBkVU2q-:APA91bEj4PBme3lAm3bDZsSfasX3PwOg9qqTpu8yZ0RpcBtBz4km9trxP9kQ4oNe-gBwr7-aE4RD6e95eJiCsyxPnvRV0F0uRpAH8NrJozBgoJhOQpgjnL_aSN3FCh9Y7MwzB7-rPZuz';
      final body = {
        "to": token,
        "notification": {
          "title": title,
          "body": description,
          "android_channel_id": "travoapps"
        }
      };
      var response =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader:
                    'key=AAAAQEtVsGg:APA91bE7wjnBB6iSlrhut43KUipMHMfT2cfbwNwdyg-dhshZsjkdl5wgmf8ppLacdlGvCMdlGlS-7NqA8qZpgOwjtZvCHjC_iKX_7OSv5_Y7M3U8phHwqbYoouAuVZnRIXuW2xpRSNnC'
              },
              body: jsonEncode(body));
      log('status : ${response.statusCode}');
      log('body : ${response.body}');
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }
}
