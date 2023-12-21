import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/auth.state.dart';

final authStateProvider =
    NotifierProvider.autoDispose<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AutoDisposeNotifier<AuthState> {

  @override
  AuthState build() {
    return const AuthState();
  }

  goToLogin() => state = state.copyWith(page: AuthPage.login);
  goToSignup() => state = state.copyWith(page: AuthPage.signup);
  goToVerifyEmail() => state = state.copyWith(page: AuthPage.verification);

  Future<void> signup(
      {required Function onSuccess, required Function(String) onError}) async {
    // SIGNUP LOGIC
  }

  Future<void> verifyEmail(
      {required Function onSuccess, required Function(String) onError}) async {
    // EMAIL VERIFICATION
  }

  Future<void> login({required Function(String) onError}) async {
    // LOGIN LOGIC
  }

  Future<void> logout() async {
    // LOGOUT LOGIC
  }

  set name(String name) => state = state.copyWith(name: name);
  set email(String email) => state = state.copyWith(email: email);
  set password(String password) => state = state.copyWith(password: password);
  set verificationCode(String code) =>
      state = state.copyWith(verificationCode: code);
}
