extension NullHelpers on Object? {
  R? let<R>(R Function(Object value) map) {
    return this == null ? null : map(this!);
  }
}
