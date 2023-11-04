import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(const ChangeThemeState(value: false));

 onDarkMode(){
  emit(const ChangeThemeState(value: true));
 }
 onLightMode(){
   emit(const ChangeThemeState(value: false));
 }
}
