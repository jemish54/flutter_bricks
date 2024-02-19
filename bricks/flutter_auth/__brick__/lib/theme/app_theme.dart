import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'component_themes.dart';

class AppTheme {
  Color seedColor;
  Brightness brightness;

  late ComponentTheme _componentTheme;

  AppTheme({required this.seedColor, required this.brightness}) {
    _componentTheme = ComponentTheme(
      colors: ColorScheme.fromSeed(seedColor: seedColor),
      brightness: brightness,
    );
  }

  ThemeData themeData() => ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorSchemeSeed: seedColor,
        brightness: brightness,
        fontFamily: GoogleFonts.workSans().fontFamily,
        elevatedButtonTheme: _componentTheme.elevatedButtonThemeData,
        inputDecorationTheme: _componentTheme.textFieldTheme,
      );
}
