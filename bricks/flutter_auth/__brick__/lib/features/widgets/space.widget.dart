import 'package:flutter/material.dart';

class SpaceY extends StatelessWidget {
  const SpaceY(this.value, {super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: value,
    );
  }
}

class SpaceX extends StatelessWidget {
  const SpaceX(this.value, {super.key});

  final double value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: value,
    );
  }
}
