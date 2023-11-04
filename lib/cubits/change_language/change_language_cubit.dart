import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../localization/language_cache_helper.dart';

part 'change_language_state.dart';

class ChangeLanguageCubit extends Cubit<ChangeLanguageState> {
  ChangeLanguageCubit()
      : super(const ChangeLanguageState(locale: Locale('en')));

 getLanguage() async {
    final String cacheLanguageCode =
        await LanguageCacheHelper().getLanguageCode();
    emit(ChangeLanguageState(locale: Locale(cacheLanguageCode)));
  }

  setLanguage(String languageCode) async {
    await LanguageCacheHelper().setLanguageCode(languageCode);
    emit(ChangeLanguageState(locale: Locale(languageCode)));
  }
}
