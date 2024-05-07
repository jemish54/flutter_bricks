import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:{{name.snakeCase()}}/core/common/services/api.service.dart';
import 'package:{{name.snakeCase()}}/core/common/services/token.service.dart';
import 'package:{{name.snakeCase()}}/dependencies.dart';

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
  Future<UserModel?> get currentUser;

  Future<String> refreshToken();

  Future<void> logOut();
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final APIService apiService = getIt.get<APIService>();
  final TokenService tokenService = getIt.get<TokenService>();

  @override
  Future<UserModel?> get currentUser async {
    try {
      final response = await apiService.dio.get('/users');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      log(e.message ?? e.toString());
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> logOut() async {
    await tokenService.clear();
  }

  @override
  Future<UserModel> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await apiService.dio.post('/auth/login');

    await tokenService.saveAccessToken(response.data['access_token']);
    await tokenService.saveRefreshToken(response.data['refresh_token']);

    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.dio.post('/auth/signup');

    await tokenService.saveAccessToken(response.data['access_token']);
    await tokenService.saveRefreshToken(response.data['refresh_token']);

    return UserModel.fromJson(response.data['user']);
  }

  @override
  Future<String> refreshToken() async {
    final response = await apiService.dio.post('/auth/refresh');

    await tokenService.saveAccessToken(response.data['access_token']);
    await tokenService.saveRefreshToken(response.data['refresh_token']);
    return response.data['access_token'];
  }
}
