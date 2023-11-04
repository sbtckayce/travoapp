

import 'package:equatable/equatable.dart';

class SeatModel extends Equatable {
  final String name;
  final String type;
  const SeatModel({
    required this.name,
    required this.type,
  });

  SeatModel copyWith({
    String? name,
    String? type,
  }) {
    return SeatModel(
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'type': type,
    };
  }

  factory SeatModel.fromMap(Map<String, dynamic> map) {
    return SeatModel(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
    );
  }



  @override
  List<Object> get props => [name, type];
}
