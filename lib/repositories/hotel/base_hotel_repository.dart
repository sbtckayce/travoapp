import 'package:flutter/material.dart';

import '../../models/hotel/hotel_model.dart';


abstract class BaseHotelRepository {
  Stream<List<HotelModel>> getAllHotelWhereName(String name);
  Stream<List<HotelModel>> getAllHotel(
    int limit,
  );
  Stream<List<HotelModel>> getAllHotelMore(int limit,BuildContext context);
  Stream<List<HotelModel>> getAllHotelWherePrice(int minPrice, int maxPrice);
  Stream<List<HotelModel>> getAllHotelWhereRating(
      double minRating, double maxRating);
  Stream<List<HotelModel>> getAllHotelAZ(bool desc);

  Stream<HotelModel> getHotelWhereHotelId(String hotelId);


}
