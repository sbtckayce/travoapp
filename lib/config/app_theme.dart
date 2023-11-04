import 'package:flutter/material.dart';

import '/constants/constants.dart';

ThemeData themeLight() {
  return ThemeData(
      scaffoldBackgroundColor: scafoldColorLight,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: Colors.black,
          onBackground: Colors.white),
      useMaterial3: true,
      
      textTheme: const TextTheme(
          bodyLarge:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          bodyMedium:
              TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          bodySmall:
              TextStyle(color: Colors.white, fontWeight: FontWeight.normal)),
      switchTheme: const SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(primaryColor),
          trackColor: MaterialStatePropertyAll(scafoldColorLight)));
}

ThemeData themeDark() {
  return ThemeData(
      scaffoldBackgroundColor: scafoldColorDark,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          secondary: Colors.white,
          onBackground: Colors.black),
      useMaterial3: true,
      textTheme: const TextTheme(
          bodyLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          bodyMedium:
              TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          bodySmall:
              TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
      switchTheme: const SwitchThemeData(
          thumbColor: MaterialStatePropertyAll(primaryColor),
          trackColor: MaterialStatePropertyAll(scafoldColorDark)));
}
