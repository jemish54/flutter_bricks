import 'package:flutter/material.dart';

extension AppStyle on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDarkTheme =>
      MediaQuery.of(this).platformBrightness == Brightness.dark;
  bool get isLightTheme =>
      MediaQuery.of(this).platformBrightness == Brightness.light;
}

extension AppWindowSize on BuildContext {
  Size get windowSize => MediaQuery.sizeOf(this);

  double fractionalHeight({required double fraction}) =>
      windowSize.height * fraction;
  double fractionalWidth({required double fraction}) =>
      windowSize.width * fraction;

  bool get isMobile => windowSize.width <= 680;
  bool get isDesktop => windowSize.width > 680;
}
