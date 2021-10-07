import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s6_singleton/bloc/usuario/usuario_cubit.dart';
import 'package:s6_singleton/models/usuario.dart';


class Page1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UsuarioCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagina 1"),
        actions: [
          IconButton(onPressed: (){
            cubit.borrarUsuario();
          }, icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: BodyScaffold(),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.adb),
       onPressed: () => Navigator.pushNamed(context, "pagina2"),
     ),
   );
  }
}

class BodyScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuarioCubit, UsuarioState>(
      builder: (_, state) {

        switch (state.runtimeType) {
          case UsuarioInitial:
            return Center(child: Text("No hay info del usuario"),);
          case UsuarioActivo:
            return InfoUsuario( usuario: (state as UsuarioActivo).usuario );
          default:
            return Center(child: Text("No reconocido"),);
        }
      },
    );
  }
}

class InfoUsuario extends StatelessWidget {

  final Usuario usuario;

  const InfoUsuario({required this.usuario});

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

          ...usuario.profesiones.map((e) => ListTile(
            title: Text(e),
          ))

        ],
      ),
    );
  }
}