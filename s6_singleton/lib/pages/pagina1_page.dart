import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s6_singleton/bloc/usuario/usuario_bloc.dart';
import 'package:s6_singleton/models/usuario.dart';


class Page1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina 1"),
        actions: [
          IconButton(onPressed: (){
            BlocProvider.of<UsuarioBloc>(context).add(
              BorrarUsuario()
            );
          }, icon: Icon(Icons.delete))
        ],
      ),
      body: BlocBuilder<UsuarioBloc, UsuarioState>(
        builder: ( _ , state){
          if(state.existe){
            return InfoUsuario( usuario: state.usuario! );
          }else{
            return Center(child: Text("Sin info de usuario"),);
          }
        }
      ),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.adb),
       onPressed: () => Navigator.pushNamed(context, "pagina2"),
     ),
   );
  }
}

class InfoUsuario extends StatelessWidget {
  final Usuario usuario;

  InfoUsuario({required this.usuario});

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

          ListTile(title: Text("Nombre: ${this.usuario.nombre}"),),
          ListTile(title: Text("Edad:  ${this.usuario.edad}"),),

          Text("Profesiones", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,)),
          Divider(),

          ...this.usuario.profesiones.map((e) => ListTile(title: Text(e),),).toList()

        ],
      ),
    );
  }
}