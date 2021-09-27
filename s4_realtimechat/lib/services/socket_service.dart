import 'package:flutter/material.dart';
import 'package:s4_realtimechat/global/environments.dart';
import 'package:s4_realtimechat/services/auth_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}
class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;  
  ServerStatus get serverStatus => this._serverStatus;

  late IO.Socket _socket;
  IO.Socket get socket => this._socket;

  // SocketService(){
  //   _initConfig();
  // }

  connect() async {

    final token = await AuthService.getToken();

    _socket = IO.io( Env.apisocketUrlUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {
        'x-token': token
      }
    });

    _socket.on('connect', (_) {
      print('Conectado');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    _socket.on('disconnect', (_) {
      print('DisConectado');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect(){
    this._socket.disconnect();
  }
}