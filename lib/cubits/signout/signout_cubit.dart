
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth/auth_repository.dart';

part 'signout_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  final AuthRepository _authRepository;
  SignOutCubit(this._authRepository) : super(SignOutState());

 Future<void> signOut(BuildContext context)async{
    await _authRepository.signOut(context);
  }
}
