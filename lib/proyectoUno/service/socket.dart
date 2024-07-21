
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum statusServices{
  Online,
  Offline,
  Connecting
}

class socketService1 with ChangeNotifier {
  late IO.Socket _socket;
  statusServices _status = statusServices.Connecting;


  IO.Socket get socket => _socket;

  statusServices get status => _status;

  socketService1() {
    InitConfig();
  }

  InitConfig() {
    this._socket = IO.io('http://localhost:3000', {
      "transports": ['websocket'],
      "autoConnect": true
    });

    this._socket.onConnect((_) {
      print('Conectado');
      _status = statusServices.Online;
      notifyListeners();
    });

    this._socket.onDisconnect((_) {
      print('DESCONECTADO');
      _status = statusServices.Offline;
      notifyListeners();
    });
  }

}

