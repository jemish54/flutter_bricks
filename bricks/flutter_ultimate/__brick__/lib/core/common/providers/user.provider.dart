import 'package:{{name.snakeCase()}}/dependencies.dart';
import 'package:{{name.snakeCase()}}/features/auth/domain/repository/auth.repository.interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../entity/user.entity.dart';

part 'user.provider.g.dart';

@riverpod
Future<UserEntity?> user(UserRef ref) {
  return getIt<AuthRepository>().currentUser;
}
