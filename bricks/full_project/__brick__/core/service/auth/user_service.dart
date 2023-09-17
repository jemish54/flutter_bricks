import 'package:appwrite/appwrite.dart';

class UserService {
  UserService({required account}) : _account = account;

  final Account _account;

  Future<void> updateName(String name) async {
    await _account.updateName(name: name);
  }

  Future<void> updateEmail(String email, String password) async {
    await _account.updateEmail(email: email, password: password);
  }

  Future<void> updatePhone(String phone, String password) async {
    await _account.updatePhone(phone: phone, password: password);
  }

  Future<void> updatePassword(String password) async {
    await _account.updatePassword(password: password);
  }
}
