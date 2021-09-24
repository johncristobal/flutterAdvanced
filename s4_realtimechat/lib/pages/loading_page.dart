import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_realtimechat/pages/login_page.dart';
import 'package:s4_realtimechat/pages/usuarios_page.dart';
import 'package:s4_realtimechat/services/auth_service.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: checlLoginState(context),
        builder: (context, snapshot){
          return Center(
            child: Text('Autenticando...'),
          );
        },
      ),
   );
  }

  Future checlLoginState( BuildContext context ) async {

    final provider = Provider.of<AuthService>(context, listen: false);
    final auth = await provider.isLogged();
    if(auth) {
      //conectar socket
      //Navigator.pushReplacementNamed(context, "usuarios");
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: ( _ , __, ___) => UsuarioPage()
      ));
    }else{
      Navigator.pushReplacement(context, PageRouteBuilder(
        pageBuilder: ( _ , __, ___) => LoginPage()
      ));
    }


  }
}