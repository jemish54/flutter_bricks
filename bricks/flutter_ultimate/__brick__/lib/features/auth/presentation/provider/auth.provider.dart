import 'package:{{name.snakeCase()}}/core/common/providers/user.provider.dart';
import 'package:{{name.snakeCase()}}/core/result/result.dart';
import 'package:{{name.snakeCase()}}/dependencies.dart';
import 'package:{{name.snakeCase()}}/features/auth/domain/repository/auth.repository.interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  final _service = getIt.get<AuthRepository>();

  @override
  Future<void> build() async {}

  Future<void> registerUser(String name, String email, String password) async {
    state = const AsyncLoading();
    final result = await _service.registerWithEmailPassword(
        name: name, email: email, password: password);
    state = result.fold(
      onSuccess: (data) => AsyncData(data),
      onFailure: (message) => AsyncError(message, StackTrace.current),
    );
    ref.invalidate(userProvider);
  }

  Future<void> loginUser(String email, String password) async {
    state = const AsyncLoading();
    final result =
        await _service.loginWithEmailPassword(email: email, password: password);
    state = result.fold(
      onSuccess: (data) => AsyncData(data),
      onFailure: (message) => AsyncError(message, StackTrace.current),
    );
    ref.invalidate(userProvider);
  }

  Future<void> logoutUser() async {
    state = const AsyncLoading();
    await _service.logOut();
    ref.invalidate(userProvider);
  }
}
