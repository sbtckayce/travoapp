import 'package:hive_flutter/hive_flutter.dart';

part 'place_model.g.dart';

@HiveType(typeId: 0)
class PlaceModel extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String imageUrl;
  @HiveField(2)
  final double rating;
  @HiveField(3)
  final bool isFavourite;
  PlaceModel({
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.isFavourite,
  });

  PlaceModel copyWith({
    String? name,
    String? imageUrl,
    double? rating,
    bool? isFavourite,
  }) {
    return PlaceModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'imageUrl': imageUrl,
      'rating': rating,
      'isFavourite': isFavourite,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      name: map['name'] ?? '',
      imageUrl: map['image'] ?? '',
      rating: map['rating'] ?? 0.0,
      isFavourite: map['is_favourite'] ?? false,
    );
  }
}

List<PlaceModel> places = [
  PlaceModel(
      name: 'Korean',
      imageUrl:
          'https://images.unsplash.com/photo-1500835556837-99ac94a94552?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dHJhdmVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
      rating: 4.5,
      isFavourite: false),
  PlaceModel(
      name: 'Japan',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1675484743423-57da4e8011c2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHRyYXZlbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
      rating: 4.5,
      isFavourite: false),
  PlaceModel(
      name: 'Turkey',
      imageUrl:
          'https://images.unsplash.com/photo-1507608616759-54f48f0af0ee?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8dHJhdmVsfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
      rating: 4.5,
      isFavourite: false),
  PlaceModel(
      name: 'Dubai',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1677343210638-5d3ce6ddbf85?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHRyYXZlbHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
      rating: 4.5,
      isFavourite: false),
];
