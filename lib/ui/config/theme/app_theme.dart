import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class AppTheme {
  static ThemeData light(context) {
    return ThemeData(
      // scaffoldBackgroundColor: Styles.screenBackgroundColor,
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Styles.primaryColor,
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Styles.primaryColor.withOpacity(0.6),
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
          Styles.primaryColorValue,
          <int, Color>{
            50: Color(0xFFE0F7EB),
            100: Color(0xFFB3EBCC),
            200: Color(0xFF80DEAB),
            300: Color(0xFF4DD189),
            400: Color(0xFF26C76F),
            500: Styles.primaryColor,
            600: Color(0xFF00B74F),
            700: Color(0xFF00AE45),
            800: Color(0xFF00982B),
            900: Color(0xFF00982B),
          },
        ),
      ),
    );
  }
}
