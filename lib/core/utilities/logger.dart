class ParseErrorLogger {
  const ParseErrorLogger();

  void call(Object error, StackTrace stackTrace) {
    print('Parse error: $error\n$stackTrace');
  }
}
