import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:{{name.snakeCase()}}/core/common/utils/extensions/context.extension.dart';
import 'package:{{name.snakeCase()}}/core/common/utils/helpers/snackbar.helper.dart';
import 'package:{{name.snakeCase()}}/core/common/utils/helpers/space.helper.dart';
import 'package:{{name.snakeCase()}}/core/common/utils/validators.dart';

import '../provider/auth.provider.dart';
import 'signup.screen.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  static const String path = '/login';
  static const String name = 'Login';
  static route({List<RouteBase> routes = const []}) => GoRoute(
        path: path,
        name: name,
        pageBuilder: (context, state) => const MaterialPage(
          child: LoginScreen(),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());

    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    ref.listen(
      authNotifierProvider,
      (previous, next) {
        if (next is AsyncError) {
          context.showError(next.error.toString());
        }
      },
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FlutterLogo(size: 100),
                  Space.y(32),
                  Text(
                    'Log in',
                    style: context.textStyles.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Space.y(32),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: Validators.email,
                  ),
                  Space.y(16),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: Validators.password,
                  ),
                  Space.y(24),
                  switch (ref.watch(authNotifierProvider)) {
                    AsyncData() || AsyncError() => ElevatedButton(
                        onPressed: () async {
                          if (!formKey.value.currentState!.validate()) return;
                          await ref
                              .read(authNotifierProvider.notifier)
                              .loginUser(
                                emailController.text,
                                passwordController.text,
                              );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colors.primaryContainer,
                          foregroundColor: context.colors.onPrimaryContainer,
                        ),
                        child: Text(
                          'Log in',
                          style: context.textStyles.bodyLarge,
                        ),
                      ),
                    _ => ElevatedButton(
                        onPressed: () {},
                        child: const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                  },
                  Space.y(32),
                  GestureDetector(
                    onTap: () => context.goNamed(SignupScreen.name),
                    child: const Text(
                      'Don\'t have an account? Signup',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Space.y(48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
