import 'package:{{name.snakeCase()}}/core/config/supabase.config.dart';
import 'package:{{name.snakeCase()}}/core/result/custom_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user.model.dart';

abstract interface class AuthRemoteSource {
  Future<UserModel> registerUser({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginUser({
    required String email,
    required String password,
  });
  Stream<UserModel?> authStateStream();
  Future<void> logOut();
}

class AuthSupabaseSource implements AuthRemoteSource {
  final SupabaseClient client;

  AuthSupabaseSource(this.client);

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  @override
  Future<UserModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
        },
      );
      if (response.user == null) {
        throw const CustomException('User is null!');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      throw CustomException(e.message);
    }
  }

  @override
  Stream<UserModel?> authStateStream() {
    return client.auth.onAuthStateChange.asyncMap((event) async {
      if (event.session?.user == null) return null;
      try {
        final userData = await client
            .from(SupabaseConfig.profileTable)
            .select()
            .eq('id', event.session!.user.id)
            .single();
        return UserModel.fromJson(userData);
      } catch (e) {
        return null;
      }
    });
  }

  @override
  Future<void> logOut() async {
    return await client.auth.signOut();
  }
}
