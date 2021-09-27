import 'package:flutter/material.dart';
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

  SocketService(){
    _initConfig();
  }

  _initConfig(){
    _socket = IO.io('http://localhost:3001', {
      'transports': ['websocket'],
      'autoConnect': true
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
}