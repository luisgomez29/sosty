import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int primaryColorValue = 0xFF00BD56;
const int secondaryColorValue = 0xFF58595B;

const secondaryColor = Color(secondaryColorValue);

final lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: const Color(primaryColorValue),
  textTheme: TextTheme(
    headline1: GoogleFonts.montserrat(
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: GoogleFonts.montserrat(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: GoogleFonts.montserrat(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
    ),
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
  )),
);
