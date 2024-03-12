sealed class Result<T> {
  bool get isSuccess => this is Success;
  bool get isFailure => this is Failure;

  Success<T> get success => this as Success<T>;
  Failure get failure => this as Failure;
}

class Success<T> extends Result<T> {
  final T data;

  Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;

  Failure([this.message = "Some Unexpected Error Occured"]);
}

extension ResultExtension<T> on Result<T> {
  R fold<R>({
    required Function(T data) onSuccess,
    required Function(String message) onFailure,
  }) {
    return switch (this) {
      Success() => onSuccess(success.data),
      Failure() => onFailure(failure.message),
    };
  }
}
