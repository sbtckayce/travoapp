import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../repositories/auth/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState.initial());

  logIn(String email, String password, BuildContext context) async {
    await _authRepository.logIn(
        email: email, password: password, context: context);
  }

  setRememberEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    await _authRepository.setRememberEmailPassword(
        email: email, password: password, context: context);
  }

  getRememberEmailPassword(
      {required TextEditingController emailController,
      required TextEditingController passwordController,
      required BuildContext context}) async {
    await _authRepository.getRememberEmailPassword(
        emailController: emailController,
        passwordController: passwordController,
        context: context);
  }

  setIsRemember({required bool value, required BuildContext context}) async {
    await _authRepository.setIsRemember(value: value, context: context);
  }

  getIsRemember(
      {required ValueNotifier valueRemember,
      required BuildContext context}) async {
    await _authRepository.getIsRemember(
        valueRemember: valueRemember, context: context);
  }
}
