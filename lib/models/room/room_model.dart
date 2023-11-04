

import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final String id;
  final String hotelId;
  final String name;
  final String imageUrl;
  final int maxGuest;
  final int price;
  final List<dynamic> services;
  final int total;
  final String typePrice;
  const RoomModel({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.imageUrl,
    required this.maxGuest,
    required this.price,
    required this.services,
    required this.total,
    required this.typePrice,
  });
 
  
  RoomModel copyWith({
    String? id,
    String? hotelId,
    String? name,
    String? imageUrl,
    int? maxGuest,
    int? price,
    List<dynamic>? services,
    int? total,
    String? typePrice,
  }) {
    return RoomModel(
      id: id ?? this.id,
      hotelId: hotelId ?? this.hotelId,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      maxGuest: maxGuest ?? this.maxGuest,
      price: price ?? this.price,
      services: services ?? this.services,
      total: total ?? this.total,
      typePrice: typePrice ?? this.typePrice,
    );
  }
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'hotel': hotelId,
      'name': name,
      'image': imageUrl,
      'max_guest': maxGuest,
      'price': price,
      'services': services,
      'total': total,
      'type_price': typePrice,
    };
  }

  factory RoomModel.fromMap(String id, Map<String, dynamic> map) {
    return RoomModel(
      id: id,
      hotelId: map['hotel'] ?? '',
      name: map['name'] ?? '',
      imageUrl: map['image'] ?? '',
      maxGuest: map['max_guest'] ?? 0,
      price: map['price'] ?? 0,
      services:List<dynamic>.from((map['services']  ?? [])),
    
      total: map['total'] ?? 0,
      typePrice: map['type_price'] ?? '',
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      hotelId,
      name,
      imageUrl,
      maxGuest,
      price,
      services,
      total,
      typePrice,
    ];
  }





  
}
