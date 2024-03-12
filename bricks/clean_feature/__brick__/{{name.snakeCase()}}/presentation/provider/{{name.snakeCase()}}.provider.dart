import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{name.snakeCase()}}.provider.g.dart';

@riverpod
class {{name.pascalCase()}}Notifier extends _${{name.pascalCase()}}Notifier {

  @override
  Future<void> build() async {}
}
