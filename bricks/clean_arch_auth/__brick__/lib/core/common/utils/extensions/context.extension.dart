import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textStyles => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenHeight => screenSize.height;
  double get screenWidth => screenSize.width;
}
