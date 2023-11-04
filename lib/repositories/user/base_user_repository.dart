import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/user/user_model.dart';

abstract class BaseUserRepository{
  Stream<UserModel> getInfoUser() ;

  Stream<UserModel> getInfoUserWhereEmail(String email);

  Future<void> updateAvatar(
      UserModel userModel, File image, BuildContext context);
      
  bool checkIsEmail(String email);
}