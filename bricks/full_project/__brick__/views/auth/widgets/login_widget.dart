import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/util/context_extensions.dart';
import 'package:{{name.snakeCase()}}/util/dialog_feedback.dart';
import 'package:{{name.snakeCase()}}/util/snackbar_feedback.dart';

import '../../../widgets/async_elevated_button.dart';
import '../../../widgets/spacing_widgets.dart';
import '../providers/auth_provider.dart';

class LoginWidget extends HookConsumerWidget {
  const LoginWidget({super.key});

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
                    if (value.length < 8) {
                      return 'You should enter 8 characters here for security';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                );
              }),
              const SpaceY(16),
              Row(
                children: [
                  const SpaceX(16),
                  GestureDetector(
                    onTap: () {
                      if (authState.email.isEmpty) {
                        context.showInformation('Please enter email');
                        return;
                      }
                      context.showConfirmation(
                        title: 'Confirm Email',
                        description: authState.email,
                        onConfirm: () async {
                          final navigator = Navigator.of(context);
                          await ref
                              .read(authStateProvider.notifier)
                              .forgotPassword(
                                onSuccess: () => context.showInformation(
                                  'Reset password email will be sent on your email',
                                ),
                                onFailure: (errorMessage) =>
                                    context.showError(errorMessage),
                              );
                          navigator.pop();
                        },
                        onCancel: () {
                          Navigator.pop(context);
                          context.showInformation(
                            'Please enter correct email.',
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  const SpaceX(16),
                  Expanded(
                    child: AsyncElevatedButton(
                      onPressed: () async {
                        if (formKey.value.currentState!.validate()) {
                          await ref.read(authStateProvider.notifier).login(
                                onError: (errorMessage) =>
                                    context.showError(errorMessage),
                              );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
              const SpaceY(8),
              TextButton(
                onPressed: () =>
                    ref.read(authStateProvider.notifier).goToSignup(),
                child: const Text('Signup with TracXpense'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
