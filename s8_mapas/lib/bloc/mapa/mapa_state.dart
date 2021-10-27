part of 'mapa_bloc.dart';

@immutable
class MapaInitial {
  final bool mapaListo;
  final bool dibujar;
  final bool seguir;

  final Map<String, Polyline>? polylines;
  final LatLng? ubicacionCentral;

  MapaInitial({
    this.mapaListo = false, 
    this.dibujar = true,
    this.polylines,
    this.seguir = false,
    this.ubicacionCentral
  });

  MapaInitial copyWith({
    bool? mapaListo,
    bool? dibujar,
    Map<String, Polyline>? polylines,
    bool? seguir,
    LatLng? ubicacionCentral
  }) => MapaInitial(
    mapaListo: mapaListo ?? this.mapaListo,
    dibujar: mapaListo ?? this.dibujar,
    polylines: polylines ?? this.polylines,
    seguir: seguir ?? this.seguir,
    ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral
  );

}
