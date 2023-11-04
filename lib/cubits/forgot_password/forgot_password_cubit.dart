import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../../repositories/auth/auth_repository.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;
  ForgotPasswordCubit(this._authRepository)
      : super(ForgotPasswordState.initial());

  Future<void> forgotPassword(String email,BuildContext context) async {
    await _authRepository.forgotPassword(email: email, context: context);
  }
}
