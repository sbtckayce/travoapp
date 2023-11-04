import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/models/promo/promo_model.dart';
import '/repositories/promo/base_promo_repository.dart';
import '../../utils/show_message_util.dart';
import '/utils/variable_const.dart';

class PromoRepository extends BasePromoRepository {
  final FirebaseFirestore _firebaseFirestore;

  PromoRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
  @override
  Future<void> createPromo({required PromoModel promoModel, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.promoCollection)
          .doc(promoModel.code)
          .set(promoModel.toMap());
    } catch (e) {
       showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> deletePromo({required String name, required BuildContext context}) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.promoCollection)
          .doc(name)
          .delete();
    } catch (e) {
        showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<PromoModel> getPromo(String code) async {
    try {
      DocumentSnapshot snapshot = await _firebaseFirestore
          .collection(VariableConst.promoCollection)
          .doc(code)
          .get();

      if (snapshot.exists) {
        return PromoModel.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return PromoModel.empty();
      }
    } catch (e) {
      return PromoModel.empty();
    }
  }
}
