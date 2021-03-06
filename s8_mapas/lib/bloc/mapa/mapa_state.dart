part of 'mapa_bloc.dart';

@immutable
class MapaInitial {
  final bool mapaListo;
  final bool dibujar;
  final bool seguir;

  final Map<String, Polyline>? polylines;
  final Map<String, Marker>? markers;

  final LatLng? ubicacionCentral;

  MapaInitial({
    this.mapaListo = false, 
    this.dibujar = true,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    this.seguir = false,
    this.ubicacionCentral
  }) 
  :
  this.polylines = polylines ?? new Map(),
  this.markers = markers ?? new Map();

  MapaInitial copyWith({
    bool? mapaListo,
    bool? dibujar,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
    bool? seguir,
    LatLng? ubicacionCentral
  }) => MapaInitial(
    mapaListo: mapaListo ?? this.mapaListo,
    dibujar: mapaListo ?? this.dibujar,
    polylines: polylines ?? this.polylines,
    markers: markers ?? this.markers,
    seguir: seguir ?? this.seguir,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral
  );

}
