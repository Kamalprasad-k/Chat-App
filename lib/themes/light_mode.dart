import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade400,
    tertiary: Colors.grey.shade500,
    background: Colors.grey.shade300,
    onBackground: Colors.black87
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.inter(
      fontSize: 18.0,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 14.0,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 12.0,
    ),
  ),
);
