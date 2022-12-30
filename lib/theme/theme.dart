import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = _buildTheme();

ThemeData _buildTheme() {
  ThemeData base = ThemeData.light();
  return base.copyWith(
    textTheme: _buildTextTheme(base.textTheme),
  );
}

TextTheme _buildTextTheme(TextTheme baseTextTheme) {
  return baseTextTheme.copyWith().apply(
    fontFamily: GoogleFonts.roboto().fontFamily,
  );
}
