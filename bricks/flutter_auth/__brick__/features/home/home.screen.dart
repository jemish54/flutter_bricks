import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/core/providers/server.provider.dart';
import 'package:{{name.snakeCase()}}/features/widgets/space.widget.dart';

import '../auth/data/providers/auth_status.provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String path = '/';
  static const String name = 'Home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Welcome ${ref.watch(currentUserProvider)!.userName}'),
            const SpaceY(8),
            ElevatedButton(
              onPressed: () => ref.read(sessionManagerProvider).signOut(),
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
