

import 'package:equatable/equatable.dart';

class GuestModel extends Equatable {
  final String name;
  final String email;
  final String phone;
  const GuestModel({
    required this.name,
    required this.email,
    required this.phone,
  });

  GuestModel copyWith({
    String? name,
    String? email,
    String? phone,
  }) {
    return GuestModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory GuestModel.fromMap(Map<String, dynamic> map) {
    return GuestModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

 

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, phone];
}
