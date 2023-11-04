part of 'change_language_cubit.dart';

class ChangeLanguageState extends Equatable {
  final Locale locale;
  const ChangeLanguageState({required this.locale});
  @override
  
  List<Object?> get props => [locale];
}

