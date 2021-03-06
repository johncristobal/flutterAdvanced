part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent{}

class OnMarcarRecorrido extends MapaEvent{}

class OnSeguirUbicacion extends MapaEvent{}

class OnMovioMapa extends MapaEvent{
  final LatLng centroMapa;
  OnMovioMapa(this.centroMapa);
}

class OnLocationUpdate extends MapaEvent{
  final LatLng ubicacion;
  OnLocationUpdate(this.ubicacion);
}

class OnCrearRuta extends MapaEvent{
  final List<LatLng> coords;
  final double distance;
  final double duration;
  final String nombreDestino;

  OnCrearRuta(this.coords, this.distance, this.duration, this.nombreDestino);

}