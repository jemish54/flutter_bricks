import '../repository/{{name.snakeCase()}}.repository.interface.dart';

class ExampleUsecase implements UseCase<dynamic, ExampleParams> {
  {{name.pascalCase()}}Repository {{name.camelCase()}}Repository;

  ExampleUsecase(this.{{name.camelCase()}}Repository);

  @override
  Future<Result<dynamic>> call(ExampleParams params) async {
    throw UnimplementedError();
  }
}

class ExampleParams {

  ExampleParams();
}
