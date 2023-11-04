part of 'place_cubit.dart';

class PlaceState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlaceLoading extends PlaceState {}

class PlaceLoaded extends PlaceState {
  final List<PlaceModel> places;

  PlaceLoaded({
    required this.places,
  });

  @override
  List<Object> get props => [places];
}
class PlaceError extends PlaceState {}