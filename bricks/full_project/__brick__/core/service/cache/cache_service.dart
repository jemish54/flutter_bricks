import 'package:shared_preferences/shared_preferences.dart';

abstract class Model<T> {
  String toJson();
  T toModel(String json);
}

class CacheServiceImpl {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _prefs.clear();
  }

  String? getString(String key, [String? defaultValue]) {
    return _prefs.getString(key) ?? defaultValue;
  }

  bool? getBool(String key, [bool? defaultValue]) {
    return _prefs.getBool(key) ?? defaultValue;
  }

  double? getDouble(String key, [double? defaultValue]) {
    return _prefs.getDouble(key) ?? defaultValue;
  }

  int? getInt(String key, [int? defaultValue]) {
    return _prefs.getInt(key) ?? defaultValue;
  }

  Model<dynamic>? getModel(
    String key,
    Model<dynamic> emptyInstance, [
    Model<dynamic>? defaultValue,
  ]) {
    if (_prefs.getString(key) == null) {
      return defaultValue;
    }
    return emptyInstance.toModel(_prefs.getString(key)!);
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  Future<bool> setModel(String key, Model<dynamic> value) async {
    return await _prefs.setString(key, value.toJson());
  }
}
