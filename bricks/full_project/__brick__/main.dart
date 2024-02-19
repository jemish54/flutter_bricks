import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/router.dart';
import 'package:{{name.snakeCase()}}/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: '{{name.titleCase()}}',
      theme: AppTheme.themeData(
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: AppTheme.themeData(
        colorSchemeSeed: Colors.blueAccent,
        brightness: Brightness.dark,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
