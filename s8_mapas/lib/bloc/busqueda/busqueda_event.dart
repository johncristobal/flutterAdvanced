part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

class OnActivarMarcador extends BusquedaEvent{

}

class OnDesactivarMarcador extends BusquedaEvent{

}

class OnAgregarHistorial extends BusquedaEvent { 
  final SearchResult item;
  OnAgregarHistorial(this.item);
}
