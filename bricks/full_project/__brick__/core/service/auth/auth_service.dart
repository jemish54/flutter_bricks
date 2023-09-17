import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';

import '../../../util/either_extension.dart';

class AuthService {
  AuthService({required account}) : _account = account;

  final Account _account;

  Future<Either<String, User>> createEmailAccount(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      return success(user);
    } on AppwriteException catch (e) {
      log(e.toString());
      return failure(e.message ?? 'Creating Account Failed');
    } catch (e) {
      log(e.toString());
      return failure(e.toString());
    }
  }

  Future<Either<String, Session>> login(String email, String password) async {
    try {
      final user = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return success(user);
    } on AppwriteException catch (e) {
      log(e.toString());
      return failure(e.message ?? 'Login Failed');
    } catch (e) {
      log(e.toString());
      return failure(e.toString());
    }
  }

  Future<Either<String, Token>> forgotPassword(String email) async {
    try {
      final token = await _account.createRecovery(
          email: email, url: 'https://localhost:80/');
      return success(token);
    } on AppwriteException catch (e) {
      log(e.toString());
      return failure(e.message ?? 'Some Error Occured');
    } catch (e) {
      log(e.toString());
      return failure(e.toString());
    }
  }

  Future<void> logout() async {
    await _account.deleteSession(sessionId: 'current');
  }
}
