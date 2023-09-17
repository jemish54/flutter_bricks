import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/util/context_extensions.dart';
import 'package:{{name.snakeCase()}}/util/snackbar_feedback.dart';

import '../../../widgets/async_elevated_button.dart';
import '../../../widgets/spacing_widgets.dart';
import '../providers/auth_provider.dart';

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
              const SpaceY(16),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Name'),
                  prefixIcon: Icon(Icons.person),
                ),
                initialValue: authState.name,
                onChanged: (value) =>
                    ref.read(authStateProvider.notifier).changeName(value),
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
                    ref.read(authStateProvider.notifier).changeEmail(value),
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
                  onChanged: (value) => ref
                      .read(authStateProvider.notifier)
                      .changePassword(value),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SpaceY(16),
              AsyncElevatedButton(
                onPressed: () async {
                  if (formKey.value.currentState!.validate()) {
                    await ref.read(authStateProvider.notifier).signup(
                          onError: (errorMessage) =>
                              context.showError(errorMessage),
                        );
                  }
                },
                child: const Text('Sign Up'),
              ),
              const SizedBox(height: 8),
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
