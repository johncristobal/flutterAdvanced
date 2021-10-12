part of 'usuario_bloc.dart';

class UsuarioState {
  final bool existe;
  final Usuario? usuario;

  UsuarioState({required this.existe, this.usuario});

  UsuarioState copyWith({required existe, Usuario? usuario}) => UsuarioState(
    existe: existe,
    usuario: usuario ?? null
  );
}