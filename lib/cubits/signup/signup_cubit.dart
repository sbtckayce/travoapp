import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../repositories/auth/auth_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit(this._authRepository) : super(SignUpState.initial());

  Future<void> signup(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String country,
      required String phone}) async {
    await _authRepository.signUp(
        email: email,
        password: password,
        name: name,
        phone: phone,
        country: country,
        context: context);
  }
}
