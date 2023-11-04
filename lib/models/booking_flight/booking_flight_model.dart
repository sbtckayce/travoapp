import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '/models/promo/promo_model.dart';

import '/models/seat/seat_model.dart';

import '../card/card_model.dart';
import '../guest/guest_model.dart';

class BookingFlightModel extends Equatable {
  final String uid;
  final String flightId;
  final SeatModel seatModel;
  final String email;
  final GuestModel guest;
  final PromoModel promoCode;
  final String typePayment;
  final CardModel cardModel;
  final double price;
  final DateTime createTime;
  const BookingFlightModel(
      {this.uid = '',
      required this.flightId,
      required this.seatModel,
      required this.email,
      required this.guest,
      required this.promoCode,
      required this.typePayment,
      required this.cardModel,
      required this.createTime,
      required this.price});

  BookingFlightModel copyWith(
      {String? uid,
      String? flightId,
      SeatModel? seatModel,
      String? email,
      GuestModel? guest,
      PromoModel? promoCode,
      String? typePayment,
      CardModel? cardModel,
      DateTime? createTime,
      double? price}) {
    return BookingFlightModel(
        uid: uid ?? this.uid,
        flightId: flightId ?? this.flightId,
        seatModel: seatModel ?? this.seatModel,
        email: email ?? this.email,
        guest: guest ?? this.guest,
        promoCode: promoCode ?? this.promoCode,
        typePayment: typePayment ?? this.typePayment,
        cardModel: cardModel ?? this.cardModel,
        createTime: createTime ?? this.createTime,
        price: price ?? this.price);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flight': flightId,
      'seat': seatModel.toMap(),
      'email': email,
      'guest': guest.toMap(),
      'promo_code': promoCode.toMap(),
      'type_payment': typePayment,
      'card': cardModel.toMap(),
      'create_time': createTime.toLocal(),
      'price': price
    };
  }

  factory BookingFlightModel.fromMap(String uid, Map<String, dynamic> map) {
    return BookingFlightModel(
        uid: uid,
        flightId: map['flight'] ?? '',
        seatModel: SeatModel.fromMap(map['seat'] ?? {}),
        email: map['email'] ?? '',
        guest: GuestModel.fromMap(map['guest'] ?? {}),
        promoCode: PromoModel.fromMap(map['promo_code'] ?? ''),
        typePayment: map['type_payment'] ?? '',
        cardModel: CardModel.fromMap(map['card'] ?? {}),
        createTime: (map['create_time'] as Timestamp).toDate(),
        price: map['price'] ?? 0.0);
  }

  @override
  List<Object> get props {
    return [
      uid,
      flightId,
      seatModel,
      guest,
      promoCode,
      typePayment,
      cardModel,
      price
    ];
  }
}
