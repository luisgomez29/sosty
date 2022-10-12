import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const int primaryColorValue = 0xFF00BD56;
  static const int secondaryColorValue = 0xFF58595B;
  static const primaryColor = Color(primaryColorValue);
  static const secondaryColor = Color(secondaryColorValue);

  // Borders radius
  static const buttonBorderRadius = 5.0;
  static const checkboxBorderRadius = 4.0;

  static final headline1 = GoogleFonts.montserrat(
    fontSize: 32.0,
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
