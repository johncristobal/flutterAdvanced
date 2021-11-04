import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:s8_mapas/helpers/custom_%20marker.dart';
import 'package:s8_mapas/helpers/widgets_markers.dart';
import 'package:s8_mapas/themes/ubertheme.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaInitial> {
  MapaBloc() : super(MapaInitial());

  //controel mapar
  GoogleMapController? _mapController;

  //polilibes
  Polyline _miruta = new Polyline(
    polylineId: PolylineId("mi_ruta"),
    width: 4,

  );

  Polyline _mirutaDestino = new Polyline(
    polylineId: PolylineId("mi_ruta_destino"),
    width: 4,
    color: Colors.black87

  );

  void initMap(GoogleMapController mapController){
    if(!state.mapaListo){
      this._mapController = mapController;

      this._mapController!.setMapStyle( jsonEncode(uberTheme) );
      add(OnMapaListo());
    }
  }

  void moverCamara( LatLng destino ){
    final update = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(update);
  }

  @override
  Stream<MapaInitial> mapEventToState(MapaEvent event) async* {
    if(event is OnMapaListo){
      yield state.copyWith(mapaListo: true);
    }else if(event is OnLocationUpdate){
      yield* this._onLocationUpdate(event);
    }else if(event is OnMarcarRecorrido){
      yield* this._onMarcarRecorrido(event);
    }else if(event is OnSeguirUbicacion){
      if(!state.seguir){
        this.moverCamara( this._miruta.points[this._miruta.points.length - 1]);
      }
      yield state.copyWith(seguir: !state.seguir);
    }else if(event is OnMovioMapa){
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    }else if(event is OnCrearRuta){
      yield* this._oncrearRuta(event);
    }
    
  }

  Stream<MapaInitial> _onLocationUpdate(OnLocationUpdate event) async* {

    if(state.seguir){
      moverCamara(event.ubicacion);
    }

    List<LatLng> points = [ ...this._miruta.points, event.ubicacion ];
    this._miruta = this._miruta.copyWith(pointsParam: points);

    final currentP = state.polylines;
    currentP?['mi_ruta'] = this._miruta;

    yield state.copyWith( 
      polylines: currentP
    ); 
  }

  Stream<MapaInitial> _onMarcarRecorrido(OnMarcarRecorrido event) async*{
    if(!state.dibujar){
      this._miruta = this._miruta.copyWith( colorParam:  Colors.black87);
    }else{
      this._miruta = this._miruta.copyWith( colorParam:  Colors.transparent); 
    }

    final currentP = state.polylines;
    currentP?['mi_ruta'] = this._miruta;

    yield state.copyWith( 
      dibujar: !state.dibujar,
      polylines: currentP
    ); 
  }

  Stream<MapaInitial> _oncrearRuta(OnCrearRuta event) async*{
    this._mirutaDestino = this._mirutaDestino.copyWith(
      pointsParam: event.coords
    );

    final current = state.polylines;
    current?["mi_ruta_destino"] = this._mirutaDestino;

    //final icon = await getAssetsImageMarker();
    final icon = await getMarkerInicio( event.duration.toInt() );
    //final iconDesti = await getNetworkImageMarker();
    final iconDesti = await getMarkerDestino(event.distance, event.nombreDestino );

    final markInicio = new Marker(
      anchor: Offset(0.0, 1.0),
      markerId: MarkerId('inicio'),
      position: event.coords[0],
      icon: icon,
      infoWindow: InfoWindow(
        title: 'Mi casa',
        snippet: 'Duracion: ${(event.duration / 60).floor()} minutos'
      )
    );

    final markFinal = new Marker(
      markerId: MarkerId('destino'),
      position: event.coords[ event.coords.length - 1],
      icon: iconDesti,
      infoWindow: InfoWindow(
        title: '${event.nombreDestino}',
        snippet: 'Distancia: ${(event.distance / 1000).floor()} kms.'
      )
    );

    final newM = {...state.markers!};
    newM['inicio'] = markInicio;
    newM['destino'] = markFinal;

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      //_mapController!.showMarkerInfoWindow(MarkerId("inicio"));
//      _mapController!.showMarkerInfoWindow(MarkerId("destino"));
    });

    yield state.copyWith(
      polylines: current,
      markers: newM
    );
  } 
}
