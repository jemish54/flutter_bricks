import 'package:flutter/material.dart';

import '../features/widgets/space.helper.dart';

class ComponentTheme {
  ComponentTheme({
    required this.colors,
    required this.brightness,
  });

  ColorScheme colors;
  Brightness brightness;

  get elevatedButtonThemeData => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: Space.xy(16, 16),
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      );

  get textFieldTheme => InputDecorationTheme(
        contentPadding: Space.xy(8, 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
}
