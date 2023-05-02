import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const Color systemRed = Color(0xFFFE0202);
  static const Color systemBlue = Color(0xFF4B6AEA);
  static const Color red = Color(0xFFD22F26);
  static const Color redDark1 = Color(0xFFB1060F);
  static const Color grey = Color(0xFF737373);
  static const Color greyDark1 = Color(0xFF323223);
  static const Color greyDark2 = Color(0xFF191919);
  static const Color greyDark3 = Color(0xFF010101);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color greyLight3 = Color(0xFFE6E6E6);
  static const Color greyLight2 = Color(0xFFCBCBCB);
  static const Color greyLight1 = Color(0xFFB2B2B2);
  static Color transparent = Colors.transparent;

  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(
      fontSize: 97,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
      fontFamily: 'NetflixSans',
    ),
    displayMedium: TextStyle(
      fontSize: 61,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
      fontFamily: 'NetflixSans',
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      fontFamily: 'NetflixSans',
    ),
    headlineMedium: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      fontFamily: 'NetflixSans',
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      fontFamily: 'NetflixSans',
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      fontFamily: 'NetflixSans',
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      fontFamily: 'NetflixSans',
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      fontFamily: 'NetflixSans',
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      fontFamily: 'NetflixSans',
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      fontFamily: 'NetflixSans',
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
      fontFamily: 'NetflixSans',
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      fontFamily: 'NetflixSans',
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      fontFamily: 'NetflixSans',
    ),
  );
}
