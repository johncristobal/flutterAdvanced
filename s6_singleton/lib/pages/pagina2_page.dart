import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s6_singleton/models/usuario.dart';
import 'package:s6_singleton/services/usuario_service.dart';


class Page2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(
        title: usuarioService.existeUsuario 
        ? Text ("Pagina 2 ${usuarioService.usuario!.nombre}")
        : Text("Pgina 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Establecer usuario", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                
                usuarioService.usuario = new Usuario(
                  nombre: "JOHN", 
                  edad: 29, 
                  profesiones: ["Developer", "Web dev"]
                );
              }
            ),

            MaterialButton(
              child: Text("Cambiar edad", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioService.cambiarEdad(35);
              }
            ),

            MaterialButton(
              child: Text("Profesion",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioService.agregarProf();
              }
            )
          ],
        )
     ),
   );
  }
}