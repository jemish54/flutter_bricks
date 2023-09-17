import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../service/auth/auth_service.dart';
import '../service/auth/user_service.dart';
import 'appwrite_global_providers.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(account: ref.watch(appwriteAccountProvider));
});

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(
    account: ref.watch(appwriteAccountProvider),
  );
});
