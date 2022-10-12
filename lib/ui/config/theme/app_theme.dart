import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class AppTheme {
  static ThemeData light(context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color(Styles.primaryColorValue),
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
          Styles.primaryColorValue,
          <int, Color>{
            50: Color(Styles.primaryColorValue),
            100: Color(Styles.primaryColorValue),
            200: Color(Styles.primaryColorValue),
            300: Color(Styles.primaryColorValue),
            400: Color(Styles.primaryColorValue),
            500: Color(Styles.primaryColorValue),
            600: Color(Styles.primaryColorValue),
            700: Color(Styles.primaryColorValue),
            800: Color(Styles.primaryColorValue),
            900: Color(Styles.primaryColorValue),
          },
        ),
      ),
    );
  }
}
