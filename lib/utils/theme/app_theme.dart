import 'package:flutter/material.dart';
import 'package:skyscape/utils/theme/app_colors.dart';

class AppTheme {
  //LIGHT THEME
  static ThemeData lightTheme() => ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: const ColorScheme.light(
          primary: AppColors.purple,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 227, 199, 237),
          foregroundColor: Colors.black,
        ),
      );
  //DARK THEME
  static ThemeData darkTheme() => ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17),
        colorScheme: const ColorScheme.dark(
          primary: AppColors.purple,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromARGB(255, 227, 199, 237),
          foregroundColor: Colors.black,
        ),
      );
}
