import 'package:flutter/material.dart';
import 'package:s6_singleton/models/usuario.dart';
import 'package:s6_singleton/services/usuario_service.dart';


class Page2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
          stream: usuarioService.usuarioStream,
          builder: (BuildContext context, AsyncSnapshot<Usuario> snapshot) {
            return snapshot.hasData
            ? Text("pagina 2: ${snapshot.data!.nombre}")
            : Text("Pagina 2");
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Establecer usuario", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioService.cargarUsuario(
                  new Usuario(
                    nombre: "alex", 
                    edad: 29, 
                    profesiones: ["developer", "web", "tecnico"])
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

              }
            )
          ],
        )
     ),
   );
  }
}