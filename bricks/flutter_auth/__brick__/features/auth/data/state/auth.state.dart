import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth.state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default('') String name,
    @Default('') String email,
    @Default('') String verificationCode,
    @Default('') String password,
    @Default(AuthPage.login) AuthPage page,
    String? error,
  }) = _AuthState;
}

enum AuthPage {
  login,
  signup,
  verification,
}
