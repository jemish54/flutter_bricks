import '../result/result.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Result<SuccessType>> call(Params params);
}

class EmptyParams {}
