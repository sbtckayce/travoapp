part of 'hotel_cubit.dart';

class HotelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HotelLoading extends HotelState {}

class HotelListLoaded extends HotelState {
  final List<HotelModel> hotels;

  HotelListLoaded({
    this.hotels = const <HotelModel>[],
  });
  @override
  List<Object?> get props => [hotels];
}

class HotelLoaded extends HotelState {
  final HotelModel hotel;

  HotelLoaded({required this.hotel});
  @override
  List<Object?> get props => [hotel];
}

