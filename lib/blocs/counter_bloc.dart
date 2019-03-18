import 'dart:async';
import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {

  // initialState es el estado antes de que se hayan procesado los eventos (antes de que se haya llamado a mapEventToState).
  // initialState es un getter opcional. Si no se implementa, initialState será nulo.
  @override
  int get initialState => 0;

  /*
   * mapEventToState es un método que debe implementarse cuando una clase extiende Bloc.
   * La función toma dos argumentos: estado y evento. Se llama a mapEventToState cada vez
   * que un evento es enviado por la capa de presentación. mapEventToState debe convertir
   * ese evento, junto con el estado actual, en un nuevo estado y devolver el nuevo
   * estado en forma de un flujo que es consumido por la capa de presentación.
   */
  @override
  Stream<int> mapEventToState(int currentState, CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield currentState - 1;
        break;
      case CounterEvent.increment:
        yield currentState + 1;
        break;
    }
  }
}