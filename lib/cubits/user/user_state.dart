part of 'user_cubit.dart';

class UserState extends Equatable {
  @override
 
  List<Object?> get props => [];
}

 class UserLoading extends UserState {}

 class UserLoaded extends UserState{
  final UserModel userModel;
  final bool isEmail;
  UserLoaded({required this.userModel,this.isEmail = false});
   @override
 
  List<Object?> get props => [userModel,isEmail];
 }
