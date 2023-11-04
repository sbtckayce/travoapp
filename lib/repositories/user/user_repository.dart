import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '/repositories/user/base_user_repository.dart';

import '../../utils/show_message_util.dart';
import '../../models/user/user_model.dart';
import '/utils/variable_const.dart';

class UserRepository extends BaseUserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;

  UserRepository(
      {FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore,
      FirebaseStorage? firebaseStorage})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Stream<UserModel> getInfoUser() {
    try {
      return _firebaseFirestore
          .collection(VariableConst.userCollection)
          .doc(_firebaseAuth.currentUser!.email)
          .snapshots()
          .map((event) {
        return UserModel.fromMap(event.data() as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Stream<UserModel> getInfoUserWhereEmail(String email) {
    try {
      return _firebaseFirestore
          .collection(VariableConst.userCollection)
          .doc(email)
          .snapshots()
          .map((event) {
        return UserModel.fromMap(event.data() as Map<String, dynamic>);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  bool checkIsEmail(String email) {
    if (_firebaseAuth.currentUser!.email == email) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> updateAvatar(
      UserModel userModel, File image, BuildContext context) async {
    try {
      String? email = _firebaseAuth.currentUser!.email;
      TaskSnapshot taskSnapshot = await _firebaseStorage
          .ref()
          .child('images/avatars')
          .child(image.path)
          .putFile(
            image,
          );
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      UserModel userModelNew =
          userModel.copyWith(avatar: imageUrl, email: email);
      await _firebaseFirestore
          .collection(VariableConst.userCollection)
          .doc(userModel.email)
          .set(userModelNew.toMap());
         
          
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }
}
