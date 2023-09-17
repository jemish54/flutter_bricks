import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_state.freezed.dart';
part '{{name.snakeCase()}}_state.g.dart';

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State({}) = _{{name.pascalCase()}}State;

  factory {{name.pascalCase()}}State.fromJson(Map<String,dynamic> json) => _${{name.pascalCase()}}StateFromJson(json);
}
