
import 'package:equatable/equatable.dart';


class SearchFlightModel extends Equatable {
  final String fromPlace;
  final String toPlace;
  final DateTime date;
  final int numberPassenger;
  final String seatType;
  const SearchFlightModel({
    required this.fromPlace,
    required this.toPlace,
    required this.date,
    required this.numberPassenger,
    required this.seatType,
  });

  SearchFlightModel copyWith({
    String? fromPlace,
    String? toPlace,
    DateTime? date,
    int? numberPassenger,
    String? seatType,
  }) {
    return SearchFlightModel(
      fromPlace: fromPlace ?? this.fromPlace,
      toPlace: toPlace ?? this.toPlace,
      date: date ?? this.date,
      numberPassenger: numberPassenger ?? this.numberPassenger,
      seatType: seatType ?? this.seatType,
    );
  }


  @override
  List<Object> get props {
    return [
      fromPlace,
      toPlace,
      date,
      numberPassenger,
      seatType,
    ];
  }
}
