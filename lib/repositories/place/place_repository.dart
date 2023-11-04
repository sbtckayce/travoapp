import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/show_message_util.dart';

import '../../models/place/place_model.dart';

import '/utils/variable_const.dart';
import 'base_place_repository.dart';

class PlaceRepository extends BasePlaceRepository {
  final FirebaseFirestore _firebaseFirestore;

  PlaceRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  bool get isFavourite => false;

  @override
  Stream<List<PlaceModel>> getAllPlace() {
    try {
      return _firebaseFirestore
          .collection(VariableConst.placeCollection)
          .snapshots()
          .map((event) {
        List<PlaceModel> list = [];
        for (var doc in event.docs) {
          list.add(PlaceModel.fromMap(doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> setPlaceFavourite({required String name,required bool isFavourite,required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setBool('${VariableConst.placeFavourite}$name', isFavourite);
    } catch (e) {
       showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> getPlaceFavourite({required String name,required ValueNotifier isFavourite,required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final temp = prefs.getBool('${VariableConst.placeFavourite}$name');

      if (temp != null) {
        isFavourite.value = temp;
      }
    } catch (e) {
       showMessages(e.toString(), ContentType.warning, context);
    }
  }
  
  @override
  Stream<List<PlaceModel>> getAllPlaceWhereName(String name) {
     try {
      return _firebaseFirestore
          .collection(VariableConst.placeCollection)
          .snapshots()
          .map((event) {
        List<PlaceModel> listFromMap = [];
        List<PlaceModel> re = [];
        for (var doc in event.docs) {
          listFromMap.add(PlaceModel.fromMap(doc.data()));
        }
        if(name ==''){
          return listFromMap;
        }else{
          for(var item in listFromMap){
            if(item.name.toLowerCase().contains(name.toLowerCase())){
              re.add(item);
            }
          }
          return re;
        }
        
      });
    } catch (e) {
      throw Exception(e);
    }
  }
}
