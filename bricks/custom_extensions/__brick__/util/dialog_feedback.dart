import 'package:flutter/material.dart';

import '../widgets/async_elevated_button.dart';

extension DialogFeedback on BuildContext {
  void showConfirmation({
    String positiveText = 'Confirm',
    String negativeText = 'Cancel',
    required String title,
    required String description,
    required Function onConfirm,
    required Function onCancel,
  }) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: Text(description),
        actions: [
          AsyncElevatedButton(
            onPressed: () => onCancel(),
            child: Text(negativeText),
          ),
          AsyncElevatedButton(
            onPressed: () => onConfirm(),
            child: Text(positiveText),
          ),
        ],
      ),
    );
  }
}
