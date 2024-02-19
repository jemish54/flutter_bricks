import 'package:flutter/material.dart';

extension AppStyle on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
  bool get isLightTheme => Theme.of(this).brightness == Brightness.light;
}

extension AppWindowSize on BuildContext {
  Size get size => MediaQuery.sizeOf(this);

  double fractionalHeight({required double fraction}) => size.height * fraction;
  double fractionalWidth({required double fraction}) => size.width * fraction;

  bool get isMobile => size.width <= 680;
  bool get isDesktop => size.width > 680;
}
