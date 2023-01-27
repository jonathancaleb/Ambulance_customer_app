import 'package:ambulance_app/src/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ATextTheme {
  ATextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: aDarkColor),
    headline2: GoogleFonts.montserrat(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: aDarkColor),
    headline3: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: aDarkColor),
    headline4: GoogleFonts.montserrat(
        fontSize: 16.0, fontWeight: FontWeight.bold, color: aDarkColor),
    headline6: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: aDarkColor),
    bodyText1: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: aDarkColor),
    bodyText2: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: aDarkColor),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.montserrat(
        fontSize: 28.0, fontWeight: FontWeight.bold, color: aWhiteColor),
    headline2: GoogleFonts.montserrat(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: aWhiteColor),
    headline3: GoogleFonts.poppins(
        fontSize: 24.0, fontWeight: FontWeight.w700, color: aWhiteColor),
    headline4: GoogleFonts.poppins(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: aWhiteColor),
    headline6: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: aWhiteColor),
    bodyText1: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: aWhiteColor),
    bodyText2: GoogleFonts.poppins(
        fontSize: 14.0, fontWeight: FontWeight.normal, color: aWhiteColor),
  );
}
