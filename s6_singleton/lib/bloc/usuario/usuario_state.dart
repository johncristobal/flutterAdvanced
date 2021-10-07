
part of 'usuario_cubit.dart';

@immutable
abstract class UsuarioState {

}

class UsuarioInitial extends UsuarioState {

  final existeUsuario = false;

  @override
  String toString() {
    return 'Usuario inicial = existeusuario false';
  }
}

class UsuarioActivo extends UsuarioState {
    final existeUsuario = true;
    final Usuario usuario;

  UsuarioActivo(this.usuario);
}