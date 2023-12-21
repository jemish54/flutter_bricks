extension NullExtensions<A> on A? {
  T? apply<T>(T Function(A value) transform) =>
      this == null ? null : transform(this as A);
}
