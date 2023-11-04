
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../guest/guest_model.dart';
import '../promo/promo_model.dart';
import '/models/card/card_model.dart';

class BookingHotelModel extends Equatable {
  final String? uid;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String email;
  final String hotelId;
  final String roomId;
  final GuestModel guest;
  final PromoModel promoCode;
  final String typePayment;
  final CardModel cardModel;
  final double price;
  const BookingHotelModel(
      {this.uid = '',
      required this.dateStart,
      required this.dateEnd,
      required this.email,
      required this.hotelId,
      required this.roomId,
      required this.guest,
      required this.promoCode,
      required this.typePayment,
      required this.cardModel,
      required this.price});

  BookingHotelModel copyWith(
      {String? uid,
      DateTime? dateStart,
      DateTime? dateEnd,
      String? email,
      String? hotelId,
      String? roomId,
      GuestModel? guest,
      PromoModel? promoCode,
      String? typePayment,
      CardModel? cardModel,
      double? price}) {
    return BookingHotelModel(
        uid: uid ?? this.uid,
        dateStart: dateStart ?? this.dateStart,
        dateEnd: dateEnd ?? this.dateEnd,
        email: email ?? this.email,
        hotelId: hotelId ?? this.hotelId,
        roomId: roomId ?? this.roomId,
        guest: guest ?? this.guest,
        promoCode: promoCode ?? this.promoCode,
        typePayment: typePayment ?? this.typePayment,
        cardModel: cardModel ?? this.cardModel,
        price: price ?? this.price);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date_start': dateStart.toLocal(),
      'date_end': dateEnd.toLocal(),
      'email': email,
      'hotel': hotelId,
      'room': roomId,
      'guest': guest.toMap(),
      'promo_code': promoCode.toMap(),
      'type_payment': typePayment,
      'card': cardModel.toMap(),
      'price': price
    };
  }

  factory BookingHotelModel.fromMap(String uid, Map<String, dynamic> map) {
    return BookingHotelModel(
        uid: uid,
        dateStart: (map['date_start'] as Timestamp).toDate(),
        dateEnd: (map['date_end'] as Timestamp).toDate(),
        email: map['email'] ?? '',
        hotelId: map['hotel'] ?? '',
        roomId: map['room'] ?? '',
        guest: GuestModel.fromMap(map['guest'] ?? {}),
        promoCode:  PromoModel.fromMap(map['promo_code'] ?? ''),
        typePayment: map['type_payment'] ?? '',
        cardModel: CardModel.fromMap(
          map['cardModel'] ?? {},
        ),
        price: map['price'] ?? 0.0);
  }

  @override
  List<Object> get props {
    return [
      dateStart,
      dateEnd,
      email,
      hotelId,
      roomId,
      guest,
      promoCode,
      typePayment,
      cardModel,
      price
    ];
  }
}
