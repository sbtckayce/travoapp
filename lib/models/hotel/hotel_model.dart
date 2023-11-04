import 'package:equatable/equatable.dart';

class HotelModel extends Equatable {
  final String uid;
  final String name;
  final String imageUrl;
  final String information;
  final String location;
  final String locationDescription;
  final int price;
  final double rating;
  final int totalReview;
  const HotelModel({
    this.uid = '',
    required this.name,
    required this.imageUrl,
    required this.information,
    required this.location,
    required this.locationDescription,
    required this.price,
    required this.rating,
    required this.totalReview,
  });

  HotelModel copyWith({
    String? uid,
    String? name,
    String? imageUrl,
    String? information,
    String? location,
    String? locationDescription,
    int? price,
    double? rating,
    int? totalReview,
  }) {
    return HotelModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      information: information ?? this.information,
      location: location ?? this.location,
      locationDescription: locationDescription ?? this.locationDescription,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      totalReview: totalReview ?? this.totalReview,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'information': information,
      'location': location,
      'locationDescription': locationDescription,
      'price': price,
      'rating': rating,
      'totalReview': totalReview,
    };
  }

  factory HotelModel.fromMap(String uid, Map<String, dynamic> map) {
    return HotelModel(
      uid: uid,
      name: map['name'] ?? '',
      imageUrl: map['image'] ?? '',
      information: map['information'] ?? '',
      location: map['location'] ?? '',
      locationDescription: map['location_description'] ?? '',
      price: map['price'] ?? 0,
      rating: map['rating'] ?? 0.0,
      totalReview: map['total_review'] ?? 0,
    );
  }

  @override
  List<Object> get props {
    return [
      uid,
      name,
      imageUrl,
      information,
      location,
      locationDescription,
      price,
      rating,
      totalReview,
    ];
  }
}

List<HotelModel> hotels = const [
  HotelModel(
      uid: '1',
      name: 'Golden Horizon Retreat',
      imageUrl:
          'https://images.unsplash.com/photo-1517840901100-8179e982acb7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
      information:
          'Discover a piece of heaven at Azure Sands Retreat on the enchanting Bora Bora island. With overwater bungalows perched above crystal-clear lagoons, this retreat offers an unparalleled tropical getaway. Immerse yourself in vibrant coral reefs, indulge in world-class cuisine, and let the beauty of Bora Bora captivate your soul.',
      location: 'Bora Bora, French Polynesia',
      locationDescription:
          'Azure Sands Retreat is located on Bora Bora in French Polynesia',
      price: 100,
      rating: 5.0,
      totalReview: 10),
  HotelModel(
      uid: '1',
      name: 'Golden Horizon Retreat',
      imageUrl:
          'https://images.unsplash.com/photo-1455587734955-081b22074882?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8aG90ZWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
      information:
          'Discover a piece of heaven at Azure Sands Retreat on the enchanting Bora Bora island. With overwater bungalows perched above crystal-clear lagoons, this retreat offers an unparalleled tropical getaway. Immerse yourself in vibrant coral reefs, indulge in world-class cuisine, and let the beauty of Bora Bora captivate your soul.',
      location: 'Bora Bora, French Polynesia',
      locationDescription:
          'Azure Sands Retreat is located on Bora Bora in French Polynesia',
      price: 100,
      rating: 5.0,
      totalReview: 10),
  HotelModel(
      uid: '1',
      name: 'Golden Horizon Retreat',
      imageUrl:
          'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8aG90ZWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
      information:
          'Discover a piece of heaven at Azure Sands Retreat on the enchanting Bora Bora island. With overwater bungalows perched above crystal-clear lagoons, this retreat offers an unparalleled tropical getaway. Immerse yourself in vibrant coral reefs, indulge in world-class cuisine, and let the beauty of Bora Bora captivate your soul.',
      location: 'Bora Bora, French Polynesia',
      locationDescription:
          'Azure Sands Retreat is located on Bora Bora in French Polynesia',
      price: 100,
      rating: 5.0,
      totalReview: 10),
  HotelModel(
      uid: '1',
      name: 'Golden Horizon Retreat',
      imageUrl:
          'https://images.unsplash.com/photo-1618773928121-c32242e63f39?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8aG90ZWx8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
      information:
          'Discover a piece of heaven at Azure Sands Retreat on the enchanting Bora Bora island. With overwater bungalows perched above crystal-clear lagoons, this retreat offers an unparalleled tropical getaway. Immerse yourself in vibrant coral reefs, indulge in world-class cuisine, and let the beauty of Bora Bora captivate your soul.',
      location: 'Bora Bora, French Polynesia',
      locationDescription:
          'Azure Sands Retreat is located on Bora Bora in French Polynesia',
      price: 100,
      rating: 5.0,
      totalReview: 10),
];
