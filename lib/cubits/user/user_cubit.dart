import 'dart:io';


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/repositories/user/user_repository.dart';

import '/models/user/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;
  UserCubit(this._userRepository) : super(UserLoading());

  getInfoUser() {
    emit(UserLoading());
    _userRepository.getInfoUser().listen((value) {
      emit(UserLoaded(userModel: value));
    });
  }

  updateAvatar(UserModel userModel, File image, BuildContext context) {
    _userRepository.updateAvatar(userModel, image, context);
  }

  getInfoUserWhereEmail(String email) {
    emit(UserLoading());
    _userRepository.getInfoUserWhereEmail(email).listen((value) {
      bool isEmail = _userRepository.checkIsEmail(value.email);
      emit(UserLoaded(userModel: value, isEmail: isEmail));
    });
  }
}
