import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/repositories/auth/base_auth_repository.dart';
import '/config/app_router_name.dart';
import '/utils/variable_const.dart';
import '../../models/user/user_model.dart';

import '../../utils/show_message_util.dart';

class AuthRepository extends BaseAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  AuthRepository(
      {FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<User?> get userModel => _firebaseAuth.userChanges();
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();
  User? get user => _firebaseAuth.currentUser;

  @override
  Future<void> signUp(
      {required String name,
      required String phone,
      required String country,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      showLoadingDialog(context, 'SignUp');
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          password: password,
          phoneNumber: phone,
          avatar: '',
          country: country);
      _firebaseFirestore
          .collection(VariableConst.userCollection)
          .doc(userModel.email)
          .set(userModel.toMap());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showMessages(e.code.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> logIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      showLoadingDialog(context, 'LogIn');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      showMessages(e.code.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> signOut(BuildContext context) async {
    try {
      showLoadingDialog(context, 'SignOut');

      await _firebaseAuth.signOut();
      if (context.mounted) context.goNamed(AppRouterName.auth);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showMessages(e.code.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> forgotPassword(
      {required String email, required BuildContext context}) async {
    try {
      showLoadingDialog(context, 'Send To $email');
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      if (context.mounted) context.goNamed(AppRouterName.auth);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showMessages(e.code.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> getRememberEmailPassword({required TextEditingController emailController,
     required TextEditingController passwordController,required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final emailTemp = prefs.getString(VariableConst.emailRemember);
      final passwordTemp = prefs.getString(VariableConst.passwordRemember);

      if (emailTemp != null) {
        emailController.text = emailTemp;
      }
      if (passwordTemp != null) {
        passwordController.text = passwordTemp;
      }
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> setRememberEmailPassword({required String email,required String password,required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(VariableConst.emailRemember, email);
      prefs.setString(VariableConst.passwordRemember, password);
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> getIsRemember({required ValueNotifier valueRemember, required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final temp = prefs.getBool(VariableConst.isRemember);
      if (temp != null) {
        valueRemember.value = temp;
      }
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }

  @override
  Future<void> setIsRemember({required bool value,required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(VariableConst.isRemember, value);
    } catch (e) {
      showMessages(e.toString(), ContentType.warning, context);
    }
  }
}
