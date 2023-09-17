import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String path = '/';
  static const String name = 'splash';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }
}
