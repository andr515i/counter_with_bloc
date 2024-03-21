import 'package:bloc/bloc.dart';
import 'package:counter_with_bloc/bloc/random_bloc/event/random_number_event.dart';
import 'package:counter_with_bloc/bloc/random_bloc/state/random_state.dart';


enum RandomEvent {increment, decrement}

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {
  RandomNumberBloc() : super(RandomNumberState()..init()) {
    on<RandomIncrementEvent>((event, emit) => emit(state.increment(state)));
    on<RandomDecrementEvent>((event, emit) => emit(state.decrement(state)));
  }






  
}