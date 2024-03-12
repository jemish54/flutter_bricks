import 'package:{{name.snakeCase()}}/core/result/result.dart';
import 'package:{{name.snakeCase()}}/core/usecase/usecase.dart';
import 'package:{{name.snakeCase()}}/core/common/entity/user.entity.dart';

import '../repository/auth.repository.interface.dart';

class LoginUsecase implements UseCase<UserEntity, LoginParams> {
  AuthRepository authRepository;

  LoginUsecase(this.authRepository);

  @override
  Future<Result<UserEntity>> call(LoginParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}
