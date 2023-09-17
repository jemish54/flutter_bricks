import 'package:flutter/material.dart';
import 'package:{{name.snakeCase()}}/widgets/space_helper.dart';

class ComponentTheme {
  static final ElevatedButtonThemeData elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static final textFieldTheme = InputDecorationTheme(
    contentPadding: Space.xy(8, 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
