import 'dart:developer';

import 'package:appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'appwrite_global_providers.dart';

final currentUserProvider =
    NotifierProvider<CurrentUserNotifier, User?>(CurrentUserNotifier.new);

class CurrentUserNotifier extends Notifier<User?> {
  @override
  User? build() {
    return null;
  }

  Future<void> getUser() async {
    try {
      state = await ref.read(appwriteAccountProvider).get();
    } catch (e) {
      log(e.toString());
      state = null;
    }
  }
}
