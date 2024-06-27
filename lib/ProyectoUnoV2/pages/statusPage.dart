import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/ProyectoUnoV2/service/socket.dart';
class statusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final serviceP = Provider.of<SocketService>(context);

    return Scaffold(
      body: Center(
        child: Text("Hello Word"),
      ),
    );
  }
}
