import 'package:flutter/material.dart';
import 'package:{{name.snakeCase()}}/theme/component_themes.dart';

class AppTheme {
  static ThemeData themeData({
    required Color colorSchemeSeed,
    required Brightness brightness,
  }) =>
      ThemeData(
        useMaterial3: true,
        colorSchemeSeed: colorSchemeSeed,
        brightness: brightness,
        elevatedButtonTheme: ComponentTheme.elevatedButtonThemeData,
        inputDecorationTheme: ComponentTheme.textFieldTheme,
      );
}
