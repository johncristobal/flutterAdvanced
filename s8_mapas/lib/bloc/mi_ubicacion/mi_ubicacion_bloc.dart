import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(MiUbicacionState());
  
  StreamSubscription<Position>? _subscription;

  void iniciarSeguimiento(){

    this._subscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen(( pos ) {
      print(pos);
      add( OnUbicacionCambio( new LatLng(pos.latitude, pos.longitude)));
    });
  }

  void cancelarSeguimiento(){
    this._subscription?.cancel();
  }

  @override
  Stream<MiUbicacionState> mapEventToState(MiUbicacionEvent event) async* {
    
    if(event is OnUbicacionCambio){
      yield state.copyWith(
        existeUbicacion: true,
        ubicacion: event.ubicacion
      );
    }
  }
}
