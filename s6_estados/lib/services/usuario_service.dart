import 'package:flutter/material.dart';
import 'package:s6_singleton/models/usuario.dart';


class UsuarioService with ChangeNotifier{

  Usuario? _usuario;
  Usuario? get usuario => this._usuario;
  set usuario (Usuario? u) {
    this._usuario = u;
    notifyListeners();
  }

  bool get existeUsuario => (this._usuario != null) ? true : false;

  void cambiarEdad(int edad){
    this._usuario!.edad = edad;
    notifyListeners();
  }

  void removerUsuario(){
    this._usuario = null;
    notifyListeners();
  }

  void agregarProf(){
    this._usuario!.profesiones.add("tecnico ${this._usuario!.profesiones.length + 1}");
    notifyListeners();
  }

}