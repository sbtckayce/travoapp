

import 'package:equatable/equatable.dart';

import '../guest/guest_model.dart';

class ContactModel extends Equatable {
  final String email;
  final GuestModel guestModel;
  const ContactModel({
    required this.email,
    required this.guestModel,
  });

  ContactModel copyWith({
    String? email,
    GuestModel? guestModel,
  }) {
    return ContactModel(
      email: email ?? this.email,
      guestModel: guestModel ?? this.guestModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'guestModel': guestModel.toMap(),
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      email: map['email'] ?? '',
      guestModel: GuestModel.fromMap(map['guestModel'] ?? {}),
    );
  }

  
  @override
  List<Object> get props => [email, guestModel];
}
