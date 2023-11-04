import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/localization/app_localization.dart';

import '../../utils/show_message_util.dart';
import '/repositories/hotel/base_hotel_repository.dart';

import '/models/hotel/hotel_model.dart';
import '/utils/variable_const.dart';

class HotelRepository extends BaseHotelRepository {
  final FirebaseFirestore _firebaseFirestore;

  HotelRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  DocumentSnapshot? startAfter;
  List<HotelModel> listHotel = [];
  List<HotelModel> listHotelMore = [];
  bool? isLastItem = true;
  @override
  Stream<List<HotelModel>> getAllHotel(
    int limit,
  ) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .limit(limit)
          .snapshots()
          .map((event) {
        for (var doc in event.docs) {
          listHotel.add(HotelModel.fromMap(doc.reference.id, doc.data()));
        }
        startAfter = event.docs.last;

        return listHotel;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<HotelModel>> getAllHotelMore(int limit, BuildContext context) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .limit(limit)
          .startAfterDocument(startAfter!)
          .snapshots()
          .map((event) {
        for (var doc in event.docs) {
          listHotelMore.add(HotelModel.fromMap(doc.reference.id, doc.data()));
        }

        if (event.docs.length < limit) {
          showMessages('no_more'.tr(context), ContentType.success, context);
        } else {
          showMessages('load_more'.tr(context), ContentType.success, context);
          startAfter = event.docs.last;
        }
        return [...listHotel, ...listHotelMore];
      });
    } catch (e) {
      return throw Exception(e);
    }
  }

  @override
  Stream<HotelModel> getHotelWhereHotelId(String hotelId) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .doc(hotelId)
          .snapshots()
          .map((event) {
        return HotelModel.fromMap(
            hotelId, event.data() as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Stream<List<HotelModel>> getAllHotelWherePrice(int minPrice, int maxPrice) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .where('price',
              isGreaterThanOrEqualTo: minPrice, isLessThanOrEqualTo: maxPrice)
          .snapshots()
          .map((event) {
        List<HotelModel> list = [];
        for (var doc in event.docs) {
          list.add(HotelModel.fromMap(doc.reference.id, doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<HotelModel>> getAllHotelWhereRating(
      double minRating, double maxRating) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .where('rating',
              isGreaterThanOrEqualTo: minRating, isLessThanOrEqualTo: maxRating)
          .snapshots()
          .map((event) {
        List<HotelModel> list = [];
        for (var doc in event.docs) {
          list.add(HotelModel.fromMap(doc.reference.id, doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<HotelModel>> getAllHotelAZ(bool desc) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .orderBy('name', descending: desc)
          .snapshots()
          .map((event) {
        List<HotelModel> list = [];
        for (var doc in event.docs) {
          list.add(HotelModel.fromMap(doc.reference.id, doc.data()));
        }
        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<List<HotelModel>> getAllHotelWhereName(String name) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.hotelCollection)
          .snapshots()
          .map((event) {
        List<HotelModel> listFromMap = [];
        List<HotelModel> re = [];
        for (var doc in event.docs) {
          listFromMap.add(HotelModel.fromMap(doc.reference.id, doc.data()));
        }
        if (name == '') {
          return listFromMap;
        } else {
          for (var item in listFromMap) {
            if (item.name.toLowerCase().contains(name.toLowerCase())) {
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
