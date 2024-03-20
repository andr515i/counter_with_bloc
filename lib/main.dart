import 'package:counter_with_bloc/bloc/bloc.dart';
import 'package:counter_with_bloc/bloc/event/counter_change_event.dart';
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
  void _showSnackBar(int count) {
    print(count);
    if (count % 3 == 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 500),
        key: const Key("din mor"),
        content: Text('Modulus hit: $count'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final CounterChangeBloc counterBloc = context.read<CounterChangeBloc>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: BlocBuilder<CounterChangeBloc, CounterChangeState>(
          builder: ((context, state) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'You have pushed the button this many times:',
                    ),
                    // Text(
                    // counterBloc.state.currentValue.toString(),
                    //   style: Theme.of(context).textTheme.headlineMedium,
                    // ),
                    BlocListener<CounterChangeBloc, CounterChangeState>(
                      listener: (context, state) {
                        if (state.currentValue % 3 == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.purple,
                              duration: const Duration(milliseconds: 500),
                              content:
                                  Text('Modulus hit:  ${state.currentValue}'),
                            ),
                          );
                        }
                      },
                      child: BlocBuilder<CounterChangeBloc, CounterChangeState>(
                        builder: (context, state) {
                          return Text('${state.currentValue}');
                        },
                      ),
                    ),
                  ],
                ),
              )),
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                counterBloc.add(CounterIncrementEvent());
                // _showSnackBar(counterBloc.state.currentValue);
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () {
                counterBloc.add(CounterDecrementEvent());
                _showSnackBar(counterBloc.state.currentValue);
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ));
  }
}
