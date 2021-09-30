import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s6_singleton/models/usuario.dart';
import 'package:s6_singleton/services/usuario_service.dart';


class Page1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final usuarioService = Provider.of<UsuarioService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina 1"),
        actions:[
          IconButton(
            onPressed: (){
              //remover usuaio
              usuarioService.removerUsuario();
            }, icon: Icon(Icons.exit_to_app))
        ]
      ),
      body: usuarioService.existeUsuario 
      ? InfoUsuario(usuario: usuarioService.usuario)
      : Center(child: Text("Sin info de usuario"),),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.adb),
       onPressed: () => Navigator.pushNamed(context, "pagina2"),
     ),
   );
  }
}

class InfoUsuario extends StatelessWidget {

  final Usuario? usuario;

  const InfoUsuario({this.usuario});

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

          ListTile(title: Text("Nombre: ${usuario!.nombre}"),),
          ListTile(title: Text("Edad: ${usuario!.edad}"),),

          Text("Profesiones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
          Divider(),

          ...this.usuario!.profesiones.map((e) => ListTile(title: Text("$e"),)).toList()

        ],
      ),
    );
  }
}