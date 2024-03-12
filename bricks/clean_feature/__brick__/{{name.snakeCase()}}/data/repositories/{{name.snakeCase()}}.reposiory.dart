import '../../domain/repository/{{name.snakeCase()}}.repository.interface.dart';
import '../sources/{{name.snakeCase()}}_remote.source.dart';

class {{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  {{name.pascalCase()}}RemoteSource remoteSource;

  {{name.pascalCase()}}RepositoryImpl(this.remoteSource);

}