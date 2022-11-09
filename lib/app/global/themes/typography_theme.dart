import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyTheme {
  static TextTheme mainTextTheme(BuildContext context) =>
      GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme);

  static TextStyle displayLarge = GoogleFonts.notoSans(
    fontSize: 57,
    height: 64,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displayMedium = GoogleFonts.notoSans(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displaySmall = GoogleFonts.notoSans(
    fontSize: 36,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headlineLarge = GoogleFonts.notoSans(
    fontSize: 32,
    fontWeight: FontWeight.w500,
  );

  static TextStyle headlineMedium = GoogleFonts.notoSans(
    fontSize: 28,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineSmall = GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  );

  static TextStyle titleLarge = GoogleFonts.notoSans(
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static TextStyle titleMedium = GoogleFonts.notoSans(
    fontSize: 20,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle titleRegular = GoogleFonts.notoSans(
    fontSize: 18,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleSmall = GoogleFonts.notoSans(
    fontSize: 16,
    letterSpacing: 0.1,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyLarge = GoogleFonts.notoSans(
    fontSize: 18,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyMedium = GoogleFonts.notoSans(
    fontSize: 16,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyRegular = GoogleFonts.notoSans(
    fontSize: 14,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodySmall = GoogleFonts.notoSans(
    fontSize: 12,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w400,
  );

  static TextStyle buttonTextStyle = GoogleFonts.notoSans(
    fontSize: 16,
    letterSpacing: 0.25,
    fontWeight: FontWeight.w600,
  );
}
