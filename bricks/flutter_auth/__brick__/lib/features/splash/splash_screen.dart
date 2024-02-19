import 'package:flutter/material.dart';

// SPLASH SCREEN IF USER RETRIEVAL LOGIC IS ASYNCRONOUS

class SplashScreen extends StatelessWidget {
  static const String path = '/splash';
  static const String name = 'Splash';
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
