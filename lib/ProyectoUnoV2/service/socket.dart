
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier {

  ServerStatus _status = ServerStatus.Connecting;

  SocketService() {
    this.ConfiguracionInit();
  }

  void ConfiguracionInit() {
    IO.Socket socket = IO.io('http://localhost:3000', {
      "transports": ['websocket'],
      "autoConnect": true
    });

    socket.onConnect((_) {
      print('Conectado al servidor');
    });

    socket.onDisconnect((_) => print('Desconectado'));
  }
}