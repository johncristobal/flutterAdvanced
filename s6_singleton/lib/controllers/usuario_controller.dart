import 'package:get/get.dart';
import 'package:s6_singleton/models/usuario.dart';

class UsuarioController extends GetxController{

  var existeUsuario = false.obs;
  var usuario = new Usuario().obs;

  void cargarUsuario(Usuario user){
    this.usuario.value = user;
    this.existeUsuario.value = true;
  }

 void cargarEdad(int edad){
    this.usuario.update((val) { 
      val!.edad = edad;
    });
  }

  void agregarProf(String p){
    this.usuario.update((val) { 
      val!.profesiones = [ ...val.profesiones, p];
    });
  }

}