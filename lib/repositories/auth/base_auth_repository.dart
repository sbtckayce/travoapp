import 'package:flutter/material.dart';

abstract class BaseAuthRepository {
  Future<void> signUp(
      {required String name,
      required String phone,
      required String country,
      required String email,
      required String password,
      required BuildContext context});

  Future<void> logIn(
      {required String email,
      required String password,
      required BuildContext context});

  Future<void> signOut(BuildContext context);

  Future<void> forgotPassword(
      {required String email, required BuildContext context});

  Future<void> setIsRemember({required bool value,required BuildContext context});

  Future<void> getIsRemember({required ValueNotifier valueRemember, required BuildContext context});

  Future<void> setRememberEmailPassword({required String email,required String password,required BuildContext context});

  Future<void> getRememberEmailPassword({required TextEditingController emailController,
     required TextEditingController passwordController,required BuildContext context});
}
