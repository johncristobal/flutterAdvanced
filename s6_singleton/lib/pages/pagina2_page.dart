import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s6_singleton/controllers/usuario_controller.dart';
import 'package:s6_singleton/models/usuario.dart';


class Page2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final usuarioController = Get.find<UsuarioController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina 2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text("Establecer usuario", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioController.cargarUsuario(new Usuario(
                  nombre: "Alex",
                  edad: 29
                ));

                Get.snackbar(
                  "Usuario agregado",
                   "Mensaje extra",
                  backgroundColor: Colors.white,
                  boxShadows: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10
                    )
                  ]
                );
              }
            ),

            MaterialButton(
              child: Text("Cambiar edad", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioController.cargarEdad(35);
              }
            ),

            MaterialButton(
              child: Text("Profesion",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                usuarioController.agregarProf("Profesion");
              }
            )
          ],
        )
     ),
   );
  }
}