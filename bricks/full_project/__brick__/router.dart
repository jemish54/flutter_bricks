import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'views/auth/auth_screen.dart';
import 'views/auth/providers/auth_provider.dart';
import 'views/dashboard/dashboard_screen.dart';
import 'views/home/home_screen.dart';
import 'views/other/other_screen.dart';
import 'views/splash/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider.autoDispose((ref) {
  final authStatus = ref.watch(authStatusProvider);

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
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => DashboardScreen(
          key: state.pageKey,
          child: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: HomeScreen.path,
                name: HomeScreen.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: HomeScreen(key: state.pageKey),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: OtherScreen.path,
                name: OtherScreen.name,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: OtherScreen(key: state.pageKey),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      if (authStatus.isLoading) return null;

      final isAuth = authStatus.asData?.value != null;

      final isSplash = state.uri.toString() == SplashScreen.path;
      if (isSplash) {
        return isAuth ? HomeScreen.path : AuthScreen.path;
      }

      final isLoggingIn = state.uri.toString() == AuthScreen.path;
      if (isLoggingIn) return isAuth ? HomeScreen.path : null;

      return isAuth ? null : SplashScreen.path;
    },
  );
});
