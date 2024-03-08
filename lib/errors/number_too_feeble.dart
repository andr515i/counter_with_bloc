class NumberTooFeeble {
  final String message;

  NumberTooFeeble(this.message);

  @override
  String toString() {
    return 'NumberTooFeebleError: $message';
  }

}
