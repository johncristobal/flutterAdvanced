import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:s8_mapas/models/search_result.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if(event is OnActivarMarcador){
      yield state.copyWith(seleccionManual: true);
    }else if(event is OnDesactivarMarcador){
      yield state.copyWith(seleccionManual: false);
    }else if(event is OnAgregarHistorial){
      final existe = state.historial.where((res) => res.nombreDestino == event.item.nombreDestino).length;

      if(existe == 0){
        yield state.copyWith(historial: [...state.historial, event.item]);
      }
    }
  } 
}
