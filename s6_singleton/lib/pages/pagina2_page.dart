import 'package:flutter/material.dart';
import 'package:s6_singleton/bloc/usuario/usuario_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s6_singleton/models/usuario.dart';

class Page2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final cubit = context.read<UsuarioCubit>();
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
                final newUser = new Usuario(
                  nombre: 'Alex', 
                  edad: 29, 
                  profesiones: ['Web app', 'developer']
                );
                cubit.selectUser(newUser);
              }
            ),

            MaterialButton(
              child: Text("Cambiar edad", style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                cubit.cambiarEdad(39);
              }
            ),

            MaterialButton(
              child: Text("Profesion",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: (){
                cubit.addProfesion();
              }
            )
          ],
        )
     ),
   );
  }
}