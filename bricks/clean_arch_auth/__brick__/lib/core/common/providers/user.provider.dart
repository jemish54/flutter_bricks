import 'package:{{name.snakeCase()}}/dependencies.dart';
import 'package:{{name.snakeCase()}}/features/auth/domain/usecase/auth_state.usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entity/user.entity.dart';

part 'user.provider.g.dart';

@riverpod
Stream<UserEntity?> user(UserRef ref) {
  return getIt<AuthStateUseCase>().call();
}
