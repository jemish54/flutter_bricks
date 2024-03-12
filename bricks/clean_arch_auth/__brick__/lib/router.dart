import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'core/common/providers/user.provider.dart';
import 'core/common/screens/error.screen.dart';
import 'core/common/screens/splash.screen.dart';
import 'features/auth/presentation/screens/login.screen.dart';
import 'features/auth/presentation/screens/signup.screen.dart';
import 'features/profile/presentation/screens/profile.screen.dart';

part 'router.g.dart';

@riverpod
GoRouter router(
  RouterRef ref,
) {
  final authState = ref.watch(userProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: ProfileScreen.path,
    redirect: (context, state) {
      if (authState.isLoading) return SplashScreen.path;
      if (authState.hasError) {
        throw GoException('Authenication Status is not available');
      }

      bool isAuthenticated = authState.requireValue != null;
      bool isAuthenticating =
          [LoginScreen.path, SignupScreen.path].contains(state.matchedLocation);

      return isAuthenticated
          ? isAuthenticating
              ? ProfileScreen.path
              : null
          : isAuthenticating
              ? null
              : LoginScreen.path;
    },
    routes: [
      GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        path: LoginScreen.path,
        name: LoginScreen.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: SignupScreen.path,
        name: SignupScreen.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: SignupScreen(),
        ),
      ),
      GoRoute(
        path: ProfileScreen.path,
        name: ProfileScreen.name,
        pageBuilder: (context, state) => const MaterialPage(
          child: ProfileScreen(),
        ),
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: ErrorScreen(
        error: state.error?.message ?? 'Some Error Occured',
      ),
    ),
  );
}
