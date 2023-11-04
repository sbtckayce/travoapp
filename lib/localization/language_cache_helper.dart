import 'package:shared_preferences/shared_preferences.dart';
import '/utils/variable_const.dart';

class LanguageCacheHelper {
  Future<void> setLanguageCode(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(VariableConst.locale, languageCode);
  }

  Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString(VariableConst.locale);
    if (locale != null) {
      return locale;
    } else {
      return 'en';
    }
  }
}
