import 'package:{{name.snakeCase()}}/core/result/error.handler.dart';
import 'package:{{name.snakeCase()}}/core/result/result.dart';
import 'package:{{name.snakeCase()}}/core/usecase/usecase.dart';

import '../repository/auth.repository.interface.dart';

class LogoutUsecase implements UseCase<void, EmptyParams> {
  final AuthRepository authRepository;

  LogoutUsecase(this.authRepository);

  @override
  Future<Result<void>> call(EmptyParams params) async {
    return await authRepository.logOut().asResult();
  }
}
