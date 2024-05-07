import 'package:{{name.snakeCase()}}/core/result/error.handler.dart';
import 'package:{{name.snakeCase()}}/core/result/result.dart';

import '../../domain/repository/auth.repository.interface.dart';
import '../models/user.model.dart';
import '../sources/auth_remote.source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteSource remoteSource;

  AuthRepositoryImpl(this.remoteSource);

  @override
  Future<Result<UserModel>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await remoteSource
        .loginUser(
          email: email,
          password: password,
        )
        .asResult();
  }

  @override
  Future<Result<UserModel>> registerWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await remoteSource
        .registerUser(
          name: name,
          email: email,
          password: password,
        )
        .asResult();
  }

  @override
  Future<UserModel?> get currentUser => remoteSource.currentUser;

  @override
  Future<void> logOut() async {
    return await remoteSource.logOut();
  }

  @override
  Future<String> refreshToken() async {
    return await remoteSource.refreshToken();
  }
}
