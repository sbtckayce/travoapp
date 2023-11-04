import 'package:equatable/equatable.dart';
import '/models/flight/flight_model.dart';
import '/models/seat/seat_model.dart';

class InfoFlightModel extends Equatable {
  final FlightModel flightModel;
  final SeatModel seatModel;
  const InfoFlightModel({
    required this.flightModel,
    required this.seatModel,
  });

  InfoFlightModel copyWith({
    FlightModel? flightModel,
    SeatModel? seatModel,
  }) {
    return InfoFlightModel(
      flightModel: flightModel ?? this.flightModel,
      seatModel: seatModel ?? this.seatModel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'flight': flightModel.toMap(),
      'seat': seatModel.toMap(),
    };
  }

  factory InfoFlightModel.fromMap(String uid, Map<String, dynamic> map) {
    return InfoFlightModel(
      flightModel: FlightModel.fromMap(uid, map['flight'] ?? []),
      seatModel: SeatModel.fromMap(map['seat'] ?? []),
    );
  }



  @override
  List<Object?> get props => [flightModel, seatModel];
}
