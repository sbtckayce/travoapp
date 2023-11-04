import 'package:flutter/material.dart';

import '../../models/place/place_model.dart';

abstract class BasePlaceRepository {
Stream<List<PlaceModel>> getAllPlace();
Stream<List<PlaceModel>> getAllPlaceWhereName(String name);
Future<void> setPlaceFavourite({required String name,required bool isFavourite,required BuildContext context});
Future<void> getPlaceFavourite({required String name,required ValueNotifier isFavourite,required BuildContext context});
}