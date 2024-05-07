import 'package:flutter/material.dart';

abstract class Space {
  static x(double width) => SizedBox(width: width);
  static y(double height) => SizedBox(height: height);
  static xy(double x, double y) => SizedBox(width: x, height: y);
}
