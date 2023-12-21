import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/features/widgets/async_button.widget.dart';
import 'package:{{name.snakeCase()}}/features/widgets/space.widget.dart';
import 'package:{{name.snakeCase()}}/util/context.extension.dart';
import 'package:{{name.snakeCase()}}/util/snackbar.extension.dart';

import '../../data/providers/auth.provider.dart';

class VerificationWidget extends HookConsumerWidget {
  const VerificationWidget({super.key});

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
                'We have sent you an email to :',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SpaceY(32),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email_rounded),
                ),
                initialValue: authState.email,
                readOnly: true,
              ),
              const SpaceY(16),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Verification Code'),
                  prefixIcon: Icon(Icons.verified_user_rounded),
                ),
                initialValue: authState.verificationCode,
                onChanged: (value) => ref
                    .read(authStateProvider.notifier)
                    .verificationCode = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter verification code';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'Enter Valid Verification Code';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SpaceY(16),
              AsyncButton(
                onPressed: () async {
                  if (formKey.value.currentState!.validate()) {
                    await ref.read(authStateProvider.notifier).verifyEmail(
                          onSuccess: () => {},
                          onError: (errorMessage) =>
                              context.showError(errorMessage),
                        );
                  }
                },
                child: const Text('Verify'),
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
