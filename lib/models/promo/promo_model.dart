import 'package:equatable/equatable.dart';

enum Endow {
  free,
  tenPercentOff,
  twentyPercentOff,
  fiftyPercentOff,
  unAvailable
}

class PromoModel extends Equatable {
  final String code;
  final String endow;
  final String image;
  final double price;
  const PromoModel({
    required this.code,
    required this.endow,
    required this.image,
    required this.price,
  });

  PromoModel copyWith({
    String? code,
    String? endow,
    String? image,
    double? price,
  }) {
    return PromoModel(
      code: code ?? this.code,
      endow: endow ?? this.endow,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  factory PromoModel.empty() {
    return PromoModel(
        code: 'empty',
        endow: Endow.unAvailable.name,
        image: 'https://cdn-icons-png.flaticon.com/128/8373/8373648.png',
        price: 0);
  }
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'endow': endow,
      'image': image,
      'price': price,
    };
  }

  factory PromoModel.fromMap(Map<String, dynamic> map) {
    return PromoModel(
        code: map['code'] ?? '',
        endow: map['endow'] ?? '',
        image: map['image'] ?? '',
        price: map['price'] ?? 0.0);
  }

  @override
  List<Object> get props => [code, endow, image, price];
}
