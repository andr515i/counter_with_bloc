import 'dart:math';
// import 'package:counter_with_bloc/errors/number_too_feeble.dart';
// import 'package:counter_with_bloc/errors/number_too_great.dart';

class RandomNumberState {
  late int _currentNumber = 0;
  late int _randomNumber = 0;
  int get currentValue => _currentNumber;

  RandomNumberState init() {
    return RandomNumberState()
      .._currentNumber = 0
      .._randomNumber = 0;
  }


// the commented out code will deadlock the counter very fast. right now i cant seem to figure out why, but i will just use this little workaround.
  RandomNumberState increment(RandomNumberState currentState) {
    return RandomNumberState()
      .._randomNumber = Random().nextInt(101)
      .._currentNumber = currentState.currentValue
      // .._currentNumber = (_currentNumber + _randomNumber) > 100
      //     ? throw NumberTooGreat(
      //         "the current number will go above 100. current number: $_currentNumber, random number: $_randomNumber")
      //     : _currentNumber += _randomNumber;
      .._currentNumber = min((_currentNumber + _randomNumber), 100);
  }

  RandomNumberState decrement(RandomNumberState currentState) {
    return RandomNumberState()
      .._randomNumber = Random().nextInt(currentState.currentValue +1)
      .._currentNumber = currentState.currentValue
      // .._currentNumber = _currentNumber - _randomNumber < 0
      //     ? throw NumberTooFeeble(
      //         "the current number will go below 0. current number: $_currentNumber, random number: $_randomNumber")
      //     : _currentNumber -= _randomNumber;
      .._currentNumber = max((_currentNumber - _randomNumber), 0);
  }

  Random rnd = Random();
}
