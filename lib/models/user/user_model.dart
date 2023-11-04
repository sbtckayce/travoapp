import 'package:equatable/equatable.dart';
import '/utils/variable_const.dart';

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String country;
  final String avatar;
  const UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.phoneNumber,
      required this.country,
      required this.avatar});

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? country,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      country: country ?? this.country,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'country': country,
      'avatar': avatar
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      country: map['country'] ?? '',
      avatar: map['avatar'] ?? VariableConst.noImageUrl,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      email,
      password,
      phoneNumber,
      country,
      avatar
    ];
  }
}
