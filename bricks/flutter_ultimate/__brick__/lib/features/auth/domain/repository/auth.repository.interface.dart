import 'package:{{name.snakeCase()}}/core/result/result.dart';
import 'package:{{name.snakeCase()}}/core/common/entity/user.entity.dart';

abstract interface class AuthRepository {
  Future<Result<UserEntity>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Result<UserEntity>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserEntity?> get currentUser;

  Future<String> refreshToken();

  Future<void> logOut();
}
