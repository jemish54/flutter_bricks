import 'package:{{name.snakeCase()}}/core/common/services/api.service.dart';
import 'package:{{name.snakeCase()}}/core/common/services/token.service.dart';
import 'package:get_it/get_it.dart';

import 'features/auth/data/sources/auth_remote.source.dart';
import 'features/auth/data/repositories/auth.repository.dart';
import 'features/auth/domain/repository/auth.repository.interface.dart';

final getIt = GetIt.instance;

Future<void> initDeps() async {
  getIt
    ..registerSingleton<TokenService>(TokenService())
    ..registerSingleton<APIService>(APIService());

  _initAuth();
}

void _initAuth() {
  getIt
    ..registerFactory<AuthRemoteSource>(
      () => AuthRemoteSourceImpl(),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteSource>()),
    );
}
