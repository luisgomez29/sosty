import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  // Color values
  static const int primaryColorValue = 0xFF00BD56;
  static const int secondaryColorValue = 0xFF5E5873;

  // Backgrounds and colors
  static const screenBackgroundColor = Color(0xFFF6F6F6);
  static const primaryColor = Color(primaryColorValue);
  static const secondaryColor = Color(secondaryColorValue);
  static const warningColor =  Color(0xFFFF9F43);

  // Padding
  static const paddingContent = 30.0;

  // Borders radius
  static const buttonBorderRadius = 5.0;
  static const checkboxBorderRadius = 4.0;

  static final headline1 = GoogleFonts.montserrat(
    fontSize: 32.0,
    fontWeight: FontWeight.w700,
    color: secondaryColor,
  );

  static final headline2 = GoogleFonts.montserrat(
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: secondaryColor,
  );

  static final headline3 = GoogleFonts.montserrat(
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    color: secondaryColor,
  );

  static final bodyText1 = GoogleFonts.montserrat(
    fontSize: 16.0,
    color: secondaryColor,
    fontWeight: FontWeight.w400,
  );

  static final bodyText1Bold = bodyText1.copyWith(
    fontWeight: FontWeight.bold,
  );

  static final bodyText2 = GoogleFonts.montserrat(
    fontSize: 14.0,
    color: secondaryColor,
    fontWeight: FontWeight.w400,
  );

  static final bodyText2Bold = bodyText2.copyWith(
    fontWeight: FontWeight.bold,
  );
}
