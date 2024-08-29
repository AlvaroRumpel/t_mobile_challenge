import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ThemeExtension on BuildContext {
  TextStyle get normal =>
      Theme.of(this).textTheme.bodyMedium ?? GoogleFonts.roboto();
}
