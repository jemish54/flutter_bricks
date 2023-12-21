import 'package:flutter/material.dart';
import 'package:serverpod_demo_flutter/util/context.extension.dart';

extension SnackBarFeedBack on BuildContext {
  void showInformation(String text) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: textTheme.labelLarge!.copyWith(color: colors.onSecondary),
        ),
        backgroundColor: colors.secondary,
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
    );
  }

  void showSuccess(String text) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: textTheme.labelLarge!.copyWith(color: colors.onBackground),
        ),
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
    );
  }

  void showError(String text) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: textTheme.labelLarge!.copyWith(color: colors.error),
        ),
        backgroundColor: colors.errorContainer,
        margin: const EdgeInsets.all(16),
        behavior: SnackBarBehavior.floating,
        elevation: 4,
      ),
    );
  }
}
