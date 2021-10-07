import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:s6_singleton/models/usuario.dart';

part 'usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {

  UsuarioCubit() : super( UsuarioInitial() );

  void selectUser (Usuario user){
    emit(UsuarioActivo(user));
  }

  void cambiarEdad (int edad){
    final currentState = state;
    if(currentState is UsuarioActivo){
      final newUser = currentState.usuario.copyWith(edad: 39);
      emit(UsuarioActivo(newUser));
    }
  }

  void addProfesion (){
    final currentState = state;
    if(currentState is UsuarioActivo){
      final profesiones = [
        ...currentState.usuario.profesiones,
        "Profesion ${currentState.usuario.profesiones.length + 1}"
      ];
      final newUser = currentState.usuario.copyWith(profesiones: profesiones);
      emit(UsuarioActivo(newUser));
    }
  }

  void borrarUsuario(){
    emit(UsuarioInitial());
  }
}