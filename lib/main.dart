import 'package:counter_with_bloc/bloc/bloc.dart';
import 'package:counter_with_bloc/bloc/event/counter_change_event.dart';
import 'package:counter_with_bloc/bloc/random_bloc/event/random_number_event.dart';
import 'package:counter_with_bloc/bloc/random_bloc/random_bloc.dart';
import 'package:counter_with_bloc/bloc/random_bloc/state/random_state.dart';
import 'package:counter_with_bloc/bloc/state/counter_change_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => CounterChangeBloc())),
          BlocProvider(create: ((context) => RandomNumberBloc())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final CounterChangeBloc counterBloc = context.read<CounterChangeBloc>();
    final RandomNumberBloc randomBloc = context.read<RandomNumberBloc>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: BlocBuilder<CounterChangeBloc, CounterChangeState>(
            builder: ((context, state) => Center(
                  child: BlocBuilder<RandomNumberBloc, RandomNumberState>(
                    builder: ((rndContext, rndState) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'You have pushed the button this many times:',
                              ),
                              BlocListener<CounterChangeBloc,
                                  CounterChangeState>(
                                listener: (context, state) {
                                  if (state.currentValue % 3 == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.purple,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content: Text(
                                            'Modulus hit:  ${state.currentValue}'),
                                      ),
                                    );
                                  }
                                },
                                child: BlocBuilder<CounterChangeBloc,
                                    CounterChangeState>(
                                  builder: (context, state) {
                                    return Text('${state.currentValue}');
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                   Text("Random Number Counter: ${rndState.currentValue}")
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FloatingActionButton(
                                    onPressed: () {
                                      counterBloc.add(CounterIncrementEvent());
                                    },
                                    tooltip: 'Increment',
                                    child: const Icon(Icons.add),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      counterBloc.add(CounterDecrementEvent());
                                    },
                                    tooltip: 'Decrement',
                                    child: const Icon(Icons.remove),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      randomBloc.add(RandomIncrementEvent());
                                    },
                                    tooltip: 'Random Increment',
                                    child: const Icon(Icons.add),
                                  ),
                                  FloatingActionButton(
                                    onPressed: () {
                                      randomBloc.add(RandomDecrementEvent());
                                    },
                                    tooltip: 'Random Decrement',
                                    child: const Icon(Icons.remove),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  ),
                ))));
  }
}
