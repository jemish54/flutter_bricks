import 'custom_exception.dart';
import 'result.dart';

extension ErrorHandler<T> on Future<T> {
  Future<Result<T>> asResult() async {
    try {
      return Success<T>(await this);
    } on CustomException catch (e) {
      return Failure<T>(e.message);
    } catch (e) {
      return Failure<T>(e.toString());
    }
  }

  Future<Result<R>> mapToResult<R>(R Function(T value) map) async {
    try {
      return Success<R>(map(await this));
    } on CustomException catch (e) {
      return Failure<R>(e.message);
    } catch (e) {
      return Failure<R>(e.toString());
    }
  }
}
