import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/localization/app_localization.dart';


import '/models/review/review_model.dart';
import '/repositories/review/base_review_repository.dart';
import '../../utils/show_message_util.dart';
import '/utils/variable_const.dart';

import '../../config/app_router_name.dart';

class ReviewRepository extends BaseReviewRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;
  ReviewRepository(
      {FirebaseFirestore? firebaseFirestore,
      FirebaseStorage? firebaseStorage,
      FirebaseAuth? firebaseAuth})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<List<ReviewModel>> getAllReviewWhereHotelId(String hotelId) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.ratingCollection)
          .where('hotel', isEqualTo: hotelId)
          .snapshots()
          .map((event) {
        List<ReviewModel> list = [];
        for (var doc in event.docs) {
          list.add(ReviewModel.fromMap(doc.reference.id, doc.data()));
        }

        return list;
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  double caculateAvgRating(List<ReviewModel> list) {
    if (list.isEmpty) {
      return 0;
    } else {
      double re = 0;
      double sum = 0;
      for (int i = 0; i < list.length; i++) {
        sum += list[i].rating;
      }
      re = sum / list.length;
      return re;
    }
  }

  @override
  Future<void> addCommentToReview(ReviewModel reviewModel,
      List<String> imageFiles, BuildContext context) async {
    try {
      showLoadingDialog(context, 'Post review');
      String? email = _firebaseAuth.currentUser!.email;

      Reference reference;

      List<String> images = [];

      for (var image in imageFiles) {
        reference =
            _firebaseStorage.ref().child('images/comments/$email').child(image);
        await reference.putFile(File(image)).whenComplete(() async {
          await reference.getDownloadURL().then((value) => images.add(value));
        });
      }
      if (images.isNotEmpty) {
        ReviewModel reviewModelNew =
            reviewModel.copyWith(userEmail: email, photos: images);

        await _firebaseFirestore
            .collection(VariableConst.ratingCollection)
            .add(reviewModelNew.toMap())
            .then((value) {
         
             showMessages('success'.tr(context), ContentType.success, context);
        });
        if (context.mounted) context.goNamed(AppRouterName.home);
      }
    } catch (e) {
      Navigator.pop(context);
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> editCommentToReview(ReviewModel reviewModel,
      List<String> imageFiles, BuildContext context) async {
    try {
      showLoadingDialog(context, 'Edit review');
      String? email = _firebaseAuth.currentUser!.email;

      Reference reference;

      List<String> images = [];

      for (var image in imageFiles) {
        reference =
            _firebaseStorage.ref().child('images/comments/$email').child(image);
        await reference.putFile(File(image)).whenComplete(() async {
          await reference.getDownloadURL().then((value) => images.add(value));
        });
      }
      if (images.isNotEmpty) {
        ReviewModel reviewModelNew =
            reviewModel.copyWith(userEmail: email, photos: images);

        await _firebaseFirestore
            .collection(VariableConst.ratingCollection)
            .doc(reviewModel.uid)
            .set(reviewModelNew.toMap())
            .then((value) {
            showMessages('success'.tr(context), ContentType.success, context);
        });
        if (context.mounted) {
          context.pop();
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    } catch (e) {
      Navigator.pop(context);
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> deleteCommentToReview(
      ReviewModel reviewModel, BuildContext context) async {
    try {
      await _firebaseFirestore
          .collection(VariableConst.ratingCollection)
          .doc(reviewModel.uid)
          .delete()
          .then((value) {
        showMessages('success'.tr(context), ContentType.success, context);
      });
      if (context.mounted) context.pop();
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }
}
