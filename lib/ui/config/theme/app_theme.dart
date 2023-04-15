import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class AppTheme {
  AppTheme._();

  static SystemUiOverlayStyle getSystemUiOverlayStyle() {
    return SystemUiOverlayStyle.light.copyWith(
      // set Status bar color in Android devices
      statusBarColor: Styles.primaryColor,

      // set Status bar icons color in Android devices
      statusBarIconBrightness: Brightness.light,

      // set Status bar icon color in iOS
      statusBarBrightness: Brightness.light,
    );
  }

  static ThemeData light(context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: Styles.primaryColor,
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Styles.primaryColor.withOpacity(0.6),
      ),
      scaffoldBackgroundColor: Colors.white,
      canvasColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      // snackBarTheme: SnackBarThemeData(
      //   contentTextStyle: TextStyle(
      //     fontSize: 16.0
      //   ),
      // ),
      // inputDecorationTheme: const InputDecorationTheme(
      //   enabledBorder: OutlineInputBorder(
      //     borderSide: BorderSide(color: Colors.black),
      //   ),
      // ),
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
