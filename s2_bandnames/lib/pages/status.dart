import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s2_bandnames/services/socket_service.dart';


class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Estatus: ${provider.serverStatus}")
          ],
        )
     ),
     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.message),
       onPressed: (){
          provider.socket.emit("emitir-mensaje", {
            "nombre":"Flutter",
            "mensaje": "Holais"
          });
       },
     ),
   );
  }
}