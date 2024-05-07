import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{name.snakeCase()}}/core/common/providers/user.provider.dart';
import 'package:{{name.snakeCase()}}/core/common/utils/helpers/space.helper.dart';
import 'package:{{name.snakeCase()}}/features/auth/presentation/provider/auth.provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  static const String path = '/profile';
  static const String name = 'Profile';
  static route({List<RouteBase> routes = const []}) => GoRoute(
        path: path,
        name: name,
        pageBuilder: (context, state) => const MaterialPage(
          child: ProfileScreen(),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(ref.watch(userProvider).requireValue?.name ?? ''),
            Space.y(16),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authNotifierProvider.notifier).logoutUser();
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
