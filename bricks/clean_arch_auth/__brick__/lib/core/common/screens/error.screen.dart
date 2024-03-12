import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({
    super.key,
    required this.error,
  });

  static const String path = '/error';
  static const String name = 'Error';

  final String error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}
