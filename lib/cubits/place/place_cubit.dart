

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/place/place_model.dart';
import '../../repositories/place/place_repository.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  final PlaceRepository _placeRepository;
  PlaceCubit(this._placeRepository) : super(PlaceLoading());

  getAllPlace()  {
    emit(PlaceLoading());

    _placeRepository.getAllPlace().listen((event) {
    
      emit(PlaceLoaded(places: event));
    });
  }
  getAllPlaceWhereName(String name){
     emit(PlaceLoading());

    _placeRepository.getAllPlaceWhereName(name).listen((event) {
      emit(PlaceLoaded(places: event));
    });
  }

  getPlaceFavourite({required String name,required ValueNotifier isFavourite,required BuildContext context}) async {
    await _placeRepository.getPlaceFavourite(name: name, isFavourite: isFavourite,context:  context);
  }

  setPlaceFavourite({required String name,required bool isFavourite,required BuildContext context}) async {
    await _placeRepository.setPlaceFavourite(name: name,isFavourite:  isFavourite,context: context);
  }
   
}
