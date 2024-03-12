import 'package:{{name.snakeCase()}}/core/result/result.dart';
import 'package:{{name.snakeCase()}}/core/usecase/usecase.dart';
import 'package:{{name.snakeCase()}}/core/common/entity/user.entity.dart';

import '../repository/auth.repository.interface.dart';

class SignupUsecase implements UseCase<UserEntity, SignupParams> {
  AuthRepository authRepository;

  SignupUsecase(this.authRepository);

  @override
  Future<Result<UserEntity>> call(SignupParams params) async {
    return await authRepository.registerWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignupParams {
  final String name;
  final String email;
  final String password;

  SignupParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
