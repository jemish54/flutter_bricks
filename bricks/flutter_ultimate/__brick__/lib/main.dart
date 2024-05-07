import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'dependencies.dart';
import 'router.dart';
import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDeps();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeProvider);
    return MaterialApp.router(
      themeMode: ThemeMode.dark,
      theme: theme.make(Colors.blue),
      darkTheme: theme.make(Colors.blue, Brightness.dark),
      routerConfig: router,
    );
  }
}
