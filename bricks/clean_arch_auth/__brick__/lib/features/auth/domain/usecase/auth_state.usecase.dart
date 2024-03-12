import 'package:{{name.snakeCase()}}/core/common/entity/user.entity.dart';

import '../repository/auth.repository.interface.dart';

class AuthStateUseCase {
  final AuthRepository authrepository;

  AuthStateUseCase(this.authrepository);

  Stream<UserEntity?> call() {
    return authrepository.authState();
  }
}
