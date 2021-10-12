import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s6_singleton/bloc/usuario/usuario_bloc.dart';
import 'package:s6_singleton/models/usuario.dart';


class Page2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
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
                BlocProvider.of<UsuarioBloc>(context).add(
                  ActivarUsuario( new Usuario(
                    nombre: 'Alex', 
                    edad: 34, 
                    profesiones: ['web', 'app']))
                );
              }
            ),

            MaterialButton(
              child: Text("Cambiar edad", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                BlocProvider.of<UsuarioBloc>(context).add(
                  CambiarEdad( 45 )
                );
              }
            ),

            MaterialButton(
              child: Text("Profesion",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                BlocProvider.of<UsuarioBloc>(context).add(
                  AgregarProfesion()
                );
              }
            )
          ],
        )
     ),
   );
  }
}