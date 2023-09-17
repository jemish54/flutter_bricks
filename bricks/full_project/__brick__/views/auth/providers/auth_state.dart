import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default('') String name,
    @Default('') String email,
    @Default('') String password,
    @Default(true) bool isLogin,
    String? error,
  }) = _AuthState;
}
