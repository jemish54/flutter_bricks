import 'package:hooks_riverpod/hooks_riverpod.dart';
import '{{name.snakeCase()}}_state.dart';

final {{name.camelCase()}}StateProvider =
    NotifierProvider.autoDispose<{{name.pascalCase()}}Notifier, {{name.pascalCase()}}State>({{name.pascalCase()}}Notifier.new);

class {{name.pascalCase()}}Notifier extends AutoDisposeNotifier<{{name.pascalCase()}}State> {

  @override
  {{name.pascalCase()}}State build() {
    return const {{name.pascalCase()}}State();
  }

}
