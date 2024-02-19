import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/views/auth/providers/auth_provider.dart';
import 'package:{{name.snakeCase()}}/widgets/spacing_widgets.dart';

import '../../widgets/async_elevated_button.dart';

class OtherScreen extends ConsumerWidget {
  const OtherScreen({super.key});

  static const String path = '/other';
  static const String name = 'other';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('OTHER SCREEN'),
            const SpaceY(16),
            AsyncElevatedButton(
              onPressed: () => ref.read(authStateProvider.notifier).logout(),
              child: const Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }
}
