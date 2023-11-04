import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/models/flight/flight_model.dart';
import '/models/search_flight/search_flight.dart';
import '/repositories/flight/base_flight_repository.dart';
import '../../utils/show_message_util.dart';
import '/utils/variable_const.dart';

class FlightRepository extends BaseFlightRepository {
  final FirebaseFirestore _firebaseFirestore;

  FlightRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<FlightModel>> getAllFlight() {
    try {
      return _firebaseFirestore
          .collection(VariableConst.flightCollection)
          .snapshots()
          .map((event) {
        List<FlightModel> list = [];
        for (var doc in event.docs) {
          list.add(FlightModel.fromMap(doc.reference.id, doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<FlightModel> getFlightWhereFlightId(String flightId) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.flightCollection)
          .doc(flightId)
          .snapshots()
          .map((event) {
        return FlightModel.fromMap(
            flightId, event.data() as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<FlightModel>> getAllFightWhereInfoFlight(
      SearchFlightModel searchFlightModel) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.flightCollection)
          .where('from_place', isEqualTo: searchFlightModel.fromPlace)
          .where('to_place', isEqualTo: searchFlightModel.toPlace)
          .where('departure_time',
              isGreaterThanOrEqualTo: searchFlightModel.date)
          .snapshots()
          .map((event) {
        List<FlightModel> list = [];
        for (var doc in event.docs) {
          list.add(FlightModel.fromMap(doc.reference.id, doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> createFlight(
      {required FlightModel flightModel, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.flightCollection)
          .add(flightModel.toMap());
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  Future<void> deleteFlight(
      {required String id, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.flightCollection)
          .doc(id)
          .delete();
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }
}
