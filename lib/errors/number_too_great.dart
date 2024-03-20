class NumberTooGreat {
  final String message;

  NumberTooGreat(this.message);

  @override
  String toString() {
    return 'NumberTooGreatError: $message';
  }

}
