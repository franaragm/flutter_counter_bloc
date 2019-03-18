import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/blocs/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
BlocBuilder maneja la construcción de un widget en respuesta a nuevos estados.
BlocBuilder es muy similar a StreamBuilder pero tiene una API más simple.

BlocProvider es un widget Flutter que proporciona un bloc a sus hijos a través de BlocProvider.of (contexto).
Se utiliza como un widget de inyección de dependencias (DI) para que se pueda proporcionar una única instancia
de un bloc a varios widgets dentro de un subárbol.
 */

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc _counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: BlocBuilder<CounterEvent, int>(
        bloc: _counterBloc,
        builder: (BuildContext context, int count) {
          return Center(
            child: Text(
              '$count',
              style: TextStyle(fontSize: 24.0),
            ),
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                // dispatch es un método que toma un evento y desencadena mapEventToState y notifica al bloc de un nuevo evento.
                _counterBloc.dispatch(CounterEvent.increment);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                _counterBloc.dispatch(CounterEvent.decrement);
              },
            ),
          ),
        ],
      ),
    );
  }
}
