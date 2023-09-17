import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers/auth_provider.dart';

import 'widgets/login_widget.dart';
import 'widgets/signup_widget.dart';

class AuthScreen extends StatelessWidget {
  static const String path = '/auth';
  static const String name = 'auth';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Consumer(builder: (context, ref, child) {
              final isLogin =
                  ref.watch(authStateProvider.select((value) => value.isLogin));
              return isLogin ? const LoginWidget() : const SignupWidget();
            }),
          ),
        ),
      ),
    );
  }
}
