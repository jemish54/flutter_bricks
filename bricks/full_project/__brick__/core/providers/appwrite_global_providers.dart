import 'package:appwrite/appwrite.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/appwrite_constants.dart';

final appwriteClientProvider = Provider<Client>((ref) {
  return Client()
      .setEndpoint(AppwriteConstants.endpoint) // Your API Endpoint
      .setProject(AppwriteConstants.projectId)
      .setSelfSigned(status: true);
});

final appwriteAccountProvider =
    Provider<Account>((ref) => Account(ref.watch(appwriteClientProvider)));
