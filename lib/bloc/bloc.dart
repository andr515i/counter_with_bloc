import 'package:bloc/bloc.dart';
import 'package:counter_with_bloc/bloc/event/counter_change_event.dart';
import 'package:counter_with_bloc/bloc/state/counter_change_state.dart';

enum CounterEvent {increment, decrement}

class CounterChangeBloc extends Bloc<CounterChangeEvent, CounterChangeState> {
  CounterChangeBloc() : super(CounterChangeState()..init()) {
    on<CounterIncrementEvent>((event, emit) => emit(state.increment(state)));
    on<CounterDecrementEvent>((event, emit) => emit(state.decrement(state)));
  }
}