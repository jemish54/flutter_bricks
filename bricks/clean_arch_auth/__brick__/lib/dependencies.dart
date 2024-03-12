import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/config/supabase.config.dart';
import 'features/auth/data/repositories/auth.reposiory.dart';
import 'features/auth/data/sources/auth_remote.source.dart';
import 'features/auth/domain/repository/auth.repository.interface.dart';
import 'features/auth/domain/usecase/auth_state.usecase.dart';
import 'features/auth/domain/usecase/login.usecase.dart';
import 'features/auth/domain/usecase/logout.usecase.dart';
import 'features/auth/domain/usecase/signup.usecase.dart';

final getIt = GetIt.instance;

Future<void> initDeps() async {
  final supabase = await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  getIt.registerLazySingleton(() => supabase.client);

  _initAuth();
}

void _initAuth() {
  getIt
    ..registerFactory<AuthRemoteSource>(
      () => AuthSupabaseSource(getIt<SupabaseClient>()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(getIt<AuthRemoteSource>()),
    )
    ..registerFactory<SignupUsecase>(
      () => SignupUsecase(getIt<AuthRepository>()),
    )
    ..registerFactory<LoginUsecase>(
      () => LoginUsecase(getIt<AuthRepository>()),
    )
    ..registerFactory<LogoutUsecase>(
      () => LogoutUsecase(getIt<AuthRepository>()),
    )
    ..registerFactory(
      () => AuthStateUseCase(getIt<AuthRepository>()),
    );
}
