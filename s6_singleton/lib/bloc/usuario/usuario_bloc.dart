import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:s6_singleton/models/usuario.dart';

part 'usuario_state.dart';
part 'usuario_event.dart';

class UsuarioBloc extends Bloc<UsuarioEvent, UsuarioState>{

  UsuarioBloc() : super(UsuarioState(existe: false));

  @override
  Stream<UsuarioState> mapEventToState(UsuarioEvent event) async* {
 
    if(event is ActivarUsuario){
      yield state.copyWith(existe: true, usuario: event.usuario);// UsuarioState(existe: true, usuario: event.usuario);
    } else if(event is CambiarEdad){
      yield state.copyWith(
        existe: true, 
        usuario: state.usuario!.copyWith(edad: event.edad)
      );
    } else if(event is AgregarProfesion){

      yield UsuarioState(
        existe: true, 
        usuario: state.usuario!.copyWith(
          profesiones: [...state.usuario!.profesiones, "${state.usuario!.profesiones.length + 1}"]
        )
      );
    } else if(event is BorrarUsuario){

      yield UsuarioState(existe: false);
    }
  }
  
}