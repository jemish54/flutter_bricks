import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/features/widgets/async_button.widget.dart';
import 'package:{{name.snakeCase()}}/features/widgets/space.widget.dart';
import 'package:{{name.snakeCase()}}/util/context.extension.dart';
import 'package:{{name.snakeCase()}}/util/snackbar.extension.dart';

import '../../data/providers/auth.provider.dart';

class SignupWidget extends HookConsumerWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final authState = ref.watch(authStateProvider);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SpaceY(32),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FlutterLogo(size: 72),
                    ),
                  )
                ],
              ),
              const SpaceY(32),
              Text(
                'Welcome',
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SpaceY(32),
              Text(
                'Enter account details here',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SpaceY(32),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.person),
                ),
                initialValue: authState.name,
                onChanged: (value) =>
                    ref.read(authStateProvider.notifier).name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'You have a name have\'t you ?';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SpaceY(16),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email_rounded),
                ),
                initialValue: authState.email,
                onChanged: (value) =>
                    ref.read(authStateProvider.notifier).email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$')
                      .hasMatch(value)) {
                    return 'Doesn\'t look like an email';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SpaceY(16),
              HookBuilder(builder: (context) {
                final showPassword = useState(false);
                return TextFormField(
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => showPassword.value = !showPassword.value,
                      icon: Icon(
                        showPassword.value
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                      ),
                    ),
                  ),
                  initialValue: authState.password,
                  obscureText: !showPassword.value,
                  onChanged: (value) =>
                      ref.read(authStateProvider.notifier).password = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 8) {
                      return 'You should enter 8 characters here for security';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SpaceY(16),
              AsyncButton(
                onPressed: () async {
                  if (formKey.value.currentState!.validate()) {
                    await ref.read(authStateProvider.notifier).signup(
                          onSuccess: () =>
                              context.showSuccess('Account Created, Sign In'),
                          onError: (errorMessage) =>
                              context.showError(errorMessage),
                        );
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () =>
                    ref.read(authStateProvider.notifier).goToLogin(),
                child: const Text('Login with TracXpense'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
