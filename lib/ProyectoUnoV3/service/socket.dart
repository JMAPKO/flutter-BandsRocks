
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum status{
  connecting,
  online,
  offline
}

class socketSERV with ChangeNotifier{

  status _estado = status.connecting;
  late IO.Socket _socket;

  status get estado => _estado;
  IO.Socket get socket => _socket;

  socketSERV(){
    InitConfig();
  }

  void InitConfig() {

    _socket = IO.io('http://localhost:3000', {
      "transports":["websocket"],
      "autoConnect": true
    });
    _socket.onConnect((_) {
      _estado = status.online;
      print('connect');
      notifyListeners();
    });

    _socket.onDisconnect((_){
      _estado = status.offline;
      print('disconnect');
      notifyListeners();
    });

  }


}