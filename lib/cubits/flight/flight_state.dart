part of 'flight_cubit.dart';

class FlightState extends Equatable {
  const FlightState();

  @override
  List<Object> get props => [];
}

class FlightLoading extends FlightState {}


class FlightListLoaded extends FlightState {
  final List<FlightModel> flights ;
  const FlightListLoaded({this.flights= const <FlightModel>[]});
    @override
  List<Object> get props => [flights];
}
class FlightLoaded extends FlightState {
  final FlightModel flight ;
  const FlightLoaded({ required this.flight});
    @override
  List<Object> get props => [flight];
}
