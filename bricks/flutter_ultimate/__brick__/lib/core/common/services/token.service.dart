import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureTokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final _secureStorage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async =>
      await _secureStorage.write(key: _accessTokenKey, value: token);
  Future<void> saveRefreshToken(String token) async =>
      await _secureStorage.write(key: _refreshTokenKey, value: token);

  Future<String?> get accessToken async =>
      await _secureStorage.read(key: _accessTokenKey);
  Future<String?> get refreshToken async =>
      await _secureStorage.read(key: _refreshTokenKey);

  Future<void> clear() async => await _secureStorage.deleteAll();
}

class TokenService {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  Future<void> saveAccessToken(String token) async =>
      await (await SharedPreferences.getInstance())
          .setString(_accessTokenKey, token);
  Future<void> saveRefreshToken(String token) async =>
      await (await SharedPreferences.getInstance())
          .setString(_refreshTokenKey, token);

  Future<String?> get accessToken async =>
      (await SharedPreferences.getInstance()).getString(_accessTokenKey);
  Future<String?> get refreshToken async =>
      (await SharedPreferences.getInstance()).getString(_refreshTokenKey);

  Future<void> clear() async => (await SharedPreferences.getInstance()).clear();
}
