import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';
import 'package:s6_singleton/controllers/usuario_controller.dart';
import 'package:s6_singleton/models/usuario.dart';


class Page1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final usuarioController = Get.put( UsuarioController() );

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina 1"),
      ),
      body: Obx(() => usuarioController.existeUsuario.value 
      ? InfoUsuario(usuario: usuarioController.usuario.value,)
      : NoInfo()),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.adb),
       //onPressed: () => Get.to( Page2Page() ),
       onPressed: () => Get.toNamed('pagina2', arguments: {
         'nombre': 'Alex',
         'edad': 29
       }),
     ),
   );
  }
}

class NoInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Sin usuario"),
    );
  }
}

class InfoUsuario extends StatelessWidget {

  final Usuario usuario;

  const InfoUsuario({Key? key, required this.usuario}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("General", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
          Divider(),

          ListTile(title: Text("Nombre: ${usuario.nombre}"),),
          ListTile(title: Text("Edad: ${usuario.edad}"),),

          Text("Profesiones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
          Divider(),

          ...usuario.profesiones.map((e) => ListTile(title: Text(e),),).toList(),


        ],
      ),
    );
  }
}