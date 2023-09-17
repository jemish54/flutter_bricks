import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/util/either_extension.dart';

import '../../../core/providers/current_user_providers.dart';
import '../../../core/providers/service_providers.dart';
import 'auth_state.dart';

final authStatusProvider = FutureProvider((ref) async {
  await ref.read(currentUserProvider.notifier).getUser();
  return ref.watch(currentUserProvider);
});

final authStateProvider =
    NotifierProvider.autoDispose<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AutoDisposeNotifier<AuthState> {
  @override
  AuthState build() {
    return const AuthState();
  }

  goToLogin() {
    state = state.copyWith(isLogin: true);
  }

  goToSignup() {
    state = state.copyWith(isLogin: false);
  }

  Future<void> signup({required Function(String) onError}) async {
    state = state.copyWith(isLoading: true);

    await ref
        .read(authServiceProvider)
        .createEmailAccount(state.name, state.email, state.password)
        .doOn(
      success: (user) async {
        state = state.copyWith(
          isLoading: false,
        );
        await login(onError: onError);
      },
      fail: (errorMessage) {
        state = state.copyWith(
          isLoading: false,
          error: errorMessage,
        );
        onError(errorMessage);
      },
    );
  }

  Future<void> login({required Function(String) onError}) async {
    state = state.copyWith(isLoading: true);

    await ref.read(authServiceProvider).login(state.email, state.password).doOn(
      success: (session) {
        state = state.copyWith(
          isLoading: false,
        );
        ref.invalidate(authStatusProvider);
      },
      fail: (errorMessage) {
        state = state.copyWith(
          isLoading: false,
          error: errorMessage,
        );
        onError(errorMessage);
      },
    );
  }

  Future<void> forgotPassword({
    required Function onSuccess,
    required Function(String) onFailure,
  }) async {
    await ref.read(authServiceProvider).forgotPassword(state.email).doOn(
          success: (success) => onSuccess(),
          fail: (fail) => onFailure(fail),
        );
  }

  Future<void> logout() async {
    await ref.read(authServiceProvider).logout();
    ref.invalidate(authStatusProvider);
  }

  changeName(String name) {
    state = state.copyWith(name: name);
  }

  changeEmail(String email) {
    state = state.copyWith(email: email);
  }

  changePassword(String password) {
    state = state.copyWith(password: password);
  }
}
