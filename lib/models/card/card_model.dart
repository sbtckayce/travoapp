import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final String name;
  final String cardNumber;
  final String expDate;
  final String cvv;
  final String country;
  const CardModel({
    required this.name,
    required this.cardNumber,
    required this.expDate,
    required this.cvv,
    required this.country,
  });
  factory CardModel.empty() {
    return const CardModel(
        name: '', cardNumber: '', expDate: '', cvv: '', country: '');
  }

  CardModel copyWith({
    String? name,
    String? cardNumber,
    String? expDate,
    String? cvv,
    String? country,
  }) {
    return CardModel(
      name: name ?? this.name,
      cardNumber: cardNumber ?? this.cardNumber,
      expDate: expDate ?? this.expDate,
      cvv: cvv ?? this.cvv,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'card_number': cardNumber,
      'exp_date': expDate,
      'cvv': cvv,
      'country': country,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      name: map['name'] ?? '',
      cardNumber: map['card_number'] ?? '',
      expDate: map['exp_date'] ?? '',
      cvv: map['cvv'] ?? '',
      country: map['country'] ?? '',
    );
  }

  @override
  List<Object> get props {
    return [
      name,
      cardNumber,
      expDate,
      cvv,
      country,
    ];
  }
}
