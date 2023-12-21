import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/features/auth/data/state/auth.state.dart';
import 'package:{{name.snakeCase()}}/features/auth/presentation/widgets/verification.widget.dart';

import '../data/providers/auth.provider.dart';
import 'widgets/login_widget.dart';
import 'widgets/signup_widget.dart';
import 'widgets/verification.widget.dart';

class AuthScreen extends StatelessWidget {
  static const String path = '/auth';
  static const String name = 'Auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Consumer(
            builder: (context, ref, child) {
              final page =
                  ref.watch(authStateProvider.select((value) => value.page));
              return switch (page) {
                AuthPage.login => const LoginWidget(),
                AuthPage.signup => const SignupWidget(),
                AuthPage.verification => const VerificationWidget(),
              };
            },
          ),
        ),
      ),
    );
  }
}
