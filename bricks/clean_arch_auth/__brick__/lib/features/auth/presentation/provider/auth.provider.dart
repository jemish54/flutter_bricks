import 'package:{{name.snakeCase()}}/core/result/result.dart';
import 'package:{{name.snakeCase()}}/core/usecase/usecase.dart';
import 'package:{{name.snakeCase()}}/dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecase/login.usecase.dart';
import '../../domain/usecase/logout.usecase.dart';
import '../../domain/usecase/signup.usecase.dart';

part 'auth.provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final SignupUsecase _signupUsecase = getIt<SignupUsecase>();
  final LoginUsecase _loginUsecase = getIt<LoginUsecase>();
  final LogoutUsecase _logoutUsecase = getIt<LogoutUsecase>();

  @override
  Future<void> build() async {}

  Future<void> registerUser(String name, String email, String password) async {
    state = const AsyncLoading();
    final result = await _signupUsecase(
        SignupParams(name: name, email: email, password: password));
    state = result.fold(
      onSuccess: (data) => AsyncData(data),
      onFailure: (message) => AsyncError(message, StackTrace.current),
    );
  }

  Future<void> loginUser(String email, String password) async {
    state = const AsyncLoading();
    final result =
        await _loginUsecase(LoginParams(email: email, password: password));
    state = result.fold(
      onSuccess: (data) => AsyncData(data),
      onFailure: (message) => AsyncError(message, StackTrace.current),
    );
  }

  Future<void> logoutUser() async {
    state = const AsyncLoading();
    await _logoutUsecase(EmptyParams());
  }
}
