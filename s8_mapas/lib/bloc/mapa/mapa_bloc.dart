import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:s8_mapas/themes/ubertheme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaInitial> {
  MapaBloc() : super(MapaInitial());

  GoogleMapController? _mapController;

  void initMap(GoogleMapController mapController){
    if(!state.mapaListo){
      this._mapController = mapController;

      this._mapController!.setMapStyle( jsonEncode(uberTheme) );
      add(OnMapaListo());
    }
  }

  void moverCamara( LatLng destino ){
    final update = CameraUpdate.newLatLng(destino);
    this._mapController!.animateCamera(update);
  }

  @override
  Stream<MapaInitial> mapEventToState(MapaEvent event) async* {
    if(event is OnMapaListo){
      yield state.copyWith(mapaListo: true);
    }
  }
}
