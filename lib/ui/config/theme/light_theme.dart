import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

ThemeData lightTheme(context) {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(primaryColorValue),
    textTheme: GoogleFonts.montserratTextTheme(
      Theme.of(context).textTheme,
    ),
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
        primaryColorValue,
        <int, Color>{
          50: Color(primaryColorValue),
          100: Color(primaryColorValue),
          200: Color(primaryColorValue),
          300: Color(primaryColorValue),
          400: Color(primaryColorValue),
          500: Color(primaryColorValue),
          600: Color(primaryColorValue),
          700: Color(primaryColorValue),
          800: Color(primaryColorValue),
          900: Color(primaryColorValue),
        },
      ),
    ),
  );
}
