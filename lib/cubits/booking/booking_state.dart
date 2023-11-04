part of 'booking_cubit.dart';

class BookingState extends Equatable {
  @override
  List<Object> get props => [];
}

class BookingLoading extends BookingState {}

class BookingListHotelLoaded extends BookingState {
  final List<BookingHotelModel> bookings;
  BookingListHotelLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}

class BookingListFlightLoaded extends BookingState {
  final List<BookingFlightModel> bookings;
  BookingListFlightLoaded({required this.bookings});

  @override
  List<Object> get props => [bookings];
}