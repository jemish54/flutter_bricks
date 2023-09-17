import 'package:hooks_riverpod/hooks_riverpod.dart';


final {{name.camelCase()}}StateProvider =
    {{name.pascalCase()}}NotifierProvider.autoDispose<{{name.pascalCase()}}Notifier, {{name.pascalCase()}}State>({{name.pascalCase()}}Notifier.new);

class {{name.pascalCase()}}Notifier extends AutoDisposeNotifier<{{name.pascalCase()}}State> {

  @override
  {{name.pascalCase()}}State build() {
    return const {{name.pascalCase()}}State();
  }

}
