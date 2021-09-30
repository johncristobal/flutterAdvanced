import 'dart:async';

import 'package:s6_singleton/models/usuario.dart';

class _UsuarioService { 

  StreamController<Usuario> _usuarioStreamController = new StreamController<Usuario>.broadcast(); 

  Stream<Usuario> get usuarioStream => _usuarioStreamController.stream;

  Usuario? _usuario;
  Usuario? get usuario => this._usuario;

  void cargarUsuario( Usuario u){
    this._usuario = u;
    this._usuarioStreamController.add(u);
  }

  bool get existeUsuario => ( this._usuario != null) ? true : false;

  void cambiarEdad(int e){
    this._usuario!.edad = e;
    this._usuarioStreamController.add(this._usuario!);
  }

  void limpiar(){
    this._usuarioStreamController.close();
  }

}

final usuarioService = new _UsuarioService();
