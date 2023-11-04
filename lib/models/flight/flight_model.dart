

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FlightModel extends Equatable {
  final String uid;
  final String fromPlace;
  final String toPlace;
  final String airline;
  final DateTime departureTime;
  final DateTime arriveTime;
  final int price;
  final String flightNo;
  final List<Map<String, List<bool>>> listMapSeat;

  const FlightModel({
    this.uid ='',
    required this.fromPlace,
    required this.toPlace,
    required this.airline,
    required this.departureTime,
    required this.arriveTime,
    required this.price,
    required this.flightNo,
    required this.listMapSeat,
  });

  FlightModel copyWith({
    String ? uid,
    String? fromPlace,
    String? toPlace,
    String? airline,
    DateTime? departureTime,
    DateTime? arriveTime,
    int? price,
    String? flightNo,
    List<Map<String, List<bool>>>? listMapSeat,
  }) {
    return FlightModel(
      uid: uid ?? this.uid,
      fromPlace: fromPlace ?? this.fromPlace,
      toPlace: toPlace ?? this.toPlace,
      airline: airline ?? this.airline,
      departureTime: departureTime ?? this.departureTime,
      arriveTime: arriveTime ?? this.arriveTime,
      price: price ?? this.price,
      flightNo: flightNo ?? this.flightNo,
      listMapSeat: listMapSeat ?? this.listMapSeat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from_place': fromPlace,
      'to_place': toPlace,
      'airline': airline,
      'departure_time': departureTime.toLocal(),
      'arrive_time': arriveTime.toLocal(),
      'price': price,
      'no': flightNo,
      'seat': listMapSeat,
    };
  }

  static List<bool> convertListDynamicToListBool(List<dynamic> data) {
    List<bool> re = [];
    for (var element in data) {
      re.add(element as bool);
    }
    return re;
  }

  factory FlightModel.fromMap(String uid,Map<String, dynamic> map) {
    return FlightModel(
      uid:  uid,
      fromPlace: map['from_place'] ?? '',
      toPlace: map['to_place'] ?? '',
      airline: map['airline'] ?? '',
      departureTime: (map['departure_time'] as Timestamp).toDate(),
      arriveTime: (map['arrive_time'] as Timestamp).toDate(),
      price: map['price'] ?? 0,
      flightNo: map['no'] ?? '',
      listMapSeat: List<Map<String, List<bool>>>.from(
        (map['seat'] as List<dynamic>).map<Map<String, List<bool>>>(
          (x) => (x as Map<String, dynamic>).map((key, value) =>
              MapEntry(key, convertListDynamicToListBool(value))),
        ),
      ),
    );
  }
  @override
  List<Object> get props {
    return [
      fromPlace,
      toPlace,
      airline,
      departureTime,
      arriveTime,
      price,
      flightNo,
      listMapSeat,
    ];
  }
}
