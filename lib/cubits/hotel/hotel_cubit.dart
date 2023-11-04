

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


import '/models/hotel/hotel_model.dart';
import '/repositories/hotel/hotel_repository.dart';

part 'hotel_state.dart';

class HotelCubit extends Cubit<HotelState> {
  final HotelRepository _hotelRepository;

  HotelCubit(this._hotelRepository) : super(HotelLoading());

  getAllHotel(int limit) {
    emit(HotelLoading());
    _hotelRepository.getAllHotel(limit).listen((event) {
      emit(HotelListLoaded(hotels: event));
    });
  }

  getAllHotelMore(int limit,BuildContext context) {
    _hotelRepository.getAllHotelMore(limit,context).listen((event) {
      emit(HotelListLoaded(hotels: event));
    });
  }

  getAllHotelWhereHotelId(String hotelId) {
    emit(HotelLoading());
    _hotelRepository.getHotelWhereHotelId(hotelId).listen((event) {
      emit(HotelLoaded(hotel: event));
    });
  }

  getAllHotelWherePrice(int minPrice, int maxPrice) {
    emit(HotelLoading());
    _hotelRepository.getAllHotelWherePrice(minPrice, maxPrice).listen((event) {
      emit(HotelListLoaded(hotels: event));
    });
  }

  getAllHotelWhereRating(double minRating, double maxRating) {
    emit(HotelLoading());
    _hotelRepository
        .getAllHotelWhereRating(minRating, maxRating)
        .listen((event) {
      emit(HotelListLoaded(hotels: event));
    });
  }

  getAllHotelAZ(bool desc) {
    emit(HotelLoading());
    _hotelRepository.getAllHotelAZ(desc).listen((event) {
      emit(HotelListLoaded(hotels: event));
    });
  }

  getAllHotelWhereName(String name) {
    emit(HotelLoading());
    _hotelRepository.getAllHotelWhereName(name).listen((event) {
      emit(HotelListLoaded(hotels: event));
    });
  }


}
