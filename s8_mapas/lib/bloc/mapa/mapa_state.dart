part of 'mapa_bloc.dart';

@immutable
class MapaInitial {
  final bool mapaListo;

  MapaInitial({this.mapaListo = false});

  MapaInitial copyWith({
    bool? mapaListo
  }) => MapaInitial(
    mapaListo: mapaListo ?? this.mapaListo
  );

}
