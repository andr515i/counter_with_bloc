class CounterChangeState {
  late int _currentNumber = 0;

  int get currentValue => _currentNumber;

  CounterChangeState init() {
    return CounterChangeState().._currentNumber = 0;
  }

  CounterChangeState increment(CounterChangeState currentState) {
    return CounterChangeState()
      .._currentNumber = currentState.currentValue
      .._currentNumber += 1;
  }

  CounterChangeState decrement(CounterChangeState currentState) {
    return CounterChangeState()
      .._currentNumber = currentState.currentValue
      .._currentNumber = _currentNumber == 0 ? 0 : _currentNumber -= 1;
  }
}
