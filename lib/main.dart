import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/blocs/counter_bloc.dart';
import 'package:flutter_counter_bloc/blocs/theme_bloc.dart';
import 'package:flutter_counter_bloc/pages/counter_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

/*
Las transiciones ocurren cuando se envía un Evento después de que se haya llamado
a mapEventToState pero antes de que se haya actualizado el estado del bloc.
Una transición consta del estado actual, el evento que se envió y el estado siguiente.

Se produce una transición cuando se envía un nuevo evento y se llama a mapEventToState.
onTransition se llama antes de que se haya actualizado el estado de un bloc.
Es un excelente lugar para agregar registros.
 */
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

/*
widget de aplicación es un StatefulWidget que es responsable de crear y eliminar un CounterBloc.
Hace que el CounterBloc esté disponible para el widget de CounterPage usando el widget
BlocProvider que mencionamos anteriormente.
 */

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final CounterBloc _counterBloc = CounterBloc();
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
      blocProviders: [
        BlocProvider<CounterBloc>(bloc: _counterBloc),
        BlocProvider<ThemeBloc>(bloc: _themeBloc)
      ],
      child: BlocBuilder(
        bloc: _themeBloc,
        builder: (_, ThemeData theme) {
          return MaterialApp(
            title: 'Flutter demo',
            home: CounterPage(),
            theme: theme,
          );
        },
      )
    );
  }

  @override
  void dispose() {
    _counterBloc.dispose(); // call the dispose method to close our Stream
    _themeBloc.dispose();
    super.dispose();
  }
}
