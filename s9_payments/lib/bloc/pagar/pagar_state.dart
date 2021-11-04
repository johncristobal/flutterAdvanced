part of 'pagar_bloc.dart';

@immutable
class PagarState {
  final double monto;
  final String moneda;
  final bool tarjetaActiva;
  final TarjetaCredito? tarjeta;

  String get montoPagar => "${(this.monto * 100).floor()}";

  PagarState({
    this.monto = 375.55, 
    this.moneda = "USD", 
    this.tarjetaActiva = false, 
    this.tarjeta
  });

  PagarState copyWith({
    double? monto,
    String? moneda,
    bool? tarjetaActiva,
    TarjetaCredito? tarjeta,
  }) => PagarState(
    monto : monto ?? this.monto,
    moneda: moneda ?? this.moneda,
    tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva,
    tarjeta: tarjeta ?? this.tarjeta
  );
}

