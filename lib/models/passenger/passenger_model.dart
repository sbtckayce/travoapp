import 'package:equatable/equatable.dart';

class PassengerModel extends Equatable {
  final String name;
  final String country;
  final String phone;
  final String email;
  const PassengerModel({
    required this.name,
    required this.country,
    required this.phone,
    required this.email,
  });

  PassengerModel copyWith({
    String? name,
    String? country,
    String? phone,
    String? email,
  }) {
    return PassengerModel(
      name: name ?? this.name,
      country: country ?? this.country,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'country': country,
      'phone': phone,
      'email': email,
    };
  }

  factory PassengerModel.fromMap(Map<String, dynamic> map) {
    return PassengerModel(
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
    );
  }

  @override
  List<Object> get props => [name, country, phone, email];
}
