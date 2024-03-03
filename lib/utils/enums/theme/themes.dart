import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: Colors.amber,
      onPrimary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      elevation: 2,
      titleTextStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600, color: Colors.black),
    ),
    primarySwatch: Colors.amber,
    brightness: Brightness.light,
    inputDecorationTheme: InputDecorationTheme(
        iconColor: Colors.amber,
        focusColor: Colors.amber,
        hintStyle: GoogleFonts.montserrat(),
        border: const OutlineInputBorder()),
  );

  static final ThemeData darkTheme = ThemeData(
    fontFamily: GoogleFonts.montserrat().fontFamily,
    colorScheme: const ColorScheme.light(
      primary: Colors.amber,
      onPrimary: Colors.black54,
    ),
    appBarTheme: AppBarTheme(
      elevation: 2,
      titleTextStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.w600, color: Colors.white),
    ),
    primarySwatch: Colors.amber,
    brightness: Brightness.dark,
    inputDecorationTheme: InputDecorationTheme(
      iconColor: Colors.amber,
      focusColor: Colors.amber,
      hintStyle: GoogleFonts.montserrat(),
      border: const OutlineInputBorder(),
    ),
  );
}
