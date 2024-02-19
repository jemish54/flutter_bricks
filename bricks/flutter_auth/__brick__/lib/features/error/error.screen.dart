import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/features/home/home.screen.dart';
import 'package:{{name.snakeCase()}}/util/context.extension.dart';

import '../widgets/space.widget.dart';

class ErrorPage extends ConsumerWidget {
  const ErrorPage({
    this.errorTitle = 'Error Displaying Page',
    this.errorDescription =
        'Path is invalid.\nRoute for this path is not found',
    this.redirectPath = HomeScreen.name,
    this.redirectText,
    super.key,
  });

  final String errorTitle;
  final String errorDescription;
  final String? redirectPath;
  final String? redirectText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Card(
          color: context.colors.errorContainer,
          margin: const EdgeInsets.all(24),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  errorTitle,
                  style: context.textTheme.titleLarge
                      ?.apply(color: context.colors.onErrorContainer),
                  textAlign: TextAlign.center,
                ),
                const SpaceY(16),
                Text(
                  errorDescription,
                  style: TextStyle(color: context.colors.onErrorContainer),
                  textAlign: TextAlign.center,
                ),
                const SpaceY(16),
                TextButton(
                  onPressed: () => context.goNamed(HomeScreen.name),
                  child: Text(redirectText ?? 'Return to Home'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
