import 'package:flutter/material.dart';

class Space {
  static EdgeInsets all(double value) => EdgeInsets.all(value);

  static EdgeInsets x(double value) => EdgeInsets.symmetric(horizontal: value);

  static EdgeInsets y(double value) => EdgeInsets.symmetric(vertical: value);

  static EdgeInsets xy(double x, double y) =>
      EdgeInsets.symmetric(horizontal: x, vertical: y);

  static EdgeInsets left(double value) => EdgeInsets.only(left: value);

  static EdgeInsets right(double value) => EdgeInsets.only(right: value);

  static EdgeInsets top(double value) => EdgeInsets.only(top: value);

  static EdgeInsets bottom(double value) => EdgeInsets.only(bottom: value);

  static EdgeInsets lrtb(double l, double r, double t, double b) =>
      EdgeInsets.only(left: l, right: r, top: t, bottom: b);
}
