import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int primaryColorValue = 0xFF00BD56;
const int secondaryColorValue = 0xFF58595B;

const primaryColor = Color(primaryColorValue);
const secondaryColor = Color(secondaryColorValue);
const buttonBorderRadius= 5.0;

final headline1 = GoogleFonts.montserrat(
  fontSize: 32.0,
  fontWeight: FontWeight.w700,
  color: secondaryColor,
);

final bodyText1 = GoogleFonts.montserrat(
  fontSize: 16.0,
  color: secondaryColor,
  fontWeight: FontWeight.w400,
);

final bodyText1Bold = bodyText1.copyWith(
  fontWeight: FontWeight.bold,
);

final bodyText2 = GoogleFonts.montserrat(
  fontSize: 14.0,
  color: secondaryColor,
  fontWeight: FontWeight.w400,
);

final bodyText2Bold = bodyText2.copyWith(
  fontWeight: FontWeight.bold,
);
