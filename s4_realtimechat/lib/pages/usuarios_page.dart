import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s4_realtimechat/models/usuario.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:s4_realtimechat/services/auth_service.dart';
import 'package:s4_realtimechat/services/chat_service.dart';
import 'package:s4_realtimechat/services/socket_service.dart';
import 'package:s4_realtimechat/services/usuarios_service.dart';

class UsuarioPage extends StatefulWidget {

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {

  final usuarioService = new UsuarioService();
  List<Usuario> usuarios = []; 

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthService>(context);
    final providerSocket = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){
            //desconetar socket server
            providerSocket.disconnect();
            Navigator.pushReplacementNamed(context, "login");
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (providerSocket.serverStatus == ServerStatus.Online) 
            ? Icon( Icons.check_circle, color: Colors.blue[400],)
            : Icon( Icons.close, color: Colors.red[400],),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: _listUsuarios(),
        onRefresh: _cargarUsuarios,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon( Icons.check ),
          waterDropColor: Colors.blue[400]!,
        ),
      )
   );
  }

  ListView _listUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _userItem(usuarios[i]), 
      separatorBuilder: (_, i) => Divider(), 
      itemCount: usuarios.length
    );
  }

  ListTile _userItem(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online 
            ? Colors.green[300]
            : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){
          final service = Provider.of<ChatService>(context, listen: false); 
          service.usuarioPara = usuario;
          Navigator.pushNamed(context, "chat");
        },
      );
  }

  _cargarUsuarios() async {

    this.usuarios = await usuarioService.getUsuarios();
    _refreshController.refreshCompleted();
    setState(() { });
  }
}