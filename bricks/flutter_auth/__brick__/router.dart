import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:serverpod_demo_flutter/features/home/home.screen.dart';

import 'features/auth/data/providers/auth_status.provider.dart';
import 'features/auth/presentation/auth.screen.dart';
import 'features/error/error.screen.dart';
import 'features/splash/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider.autoDispose((ref) {
  final authStatus = ref.watch(currentUserProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: (context, state) => MaterialPage(
          child: SplashScreen(key: state.pageKey),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: AuthScreen.path,
        name: AuthScreen.name,
        pageBuilder: (context, state) => MaterialPage(
          child: AuthScreen(key: state.pageKey),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: HomeScreen.path,
        name: HomeScreen.name,
        pageBuilder: (context, state) => MaterialPage(
          child: HomeScreen(key: state.pageKey),
        ),
      ),
    ],
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final isAuth = authStatus != null;

      final isLoggingIn = state.uri.toString() == AuthScreen.path;
      if (isLoggingIn) return isAuth ? HomeScreen.path : null;

      return isAuth ? null : AuthScreen.path;
    },
    errorPageBuilder: (context, state) =>
        const MaterialPage(child: ErrorPage()),
  );
});
