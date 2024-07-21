import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/proyectoUno/service/socket.dart';

class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<socketService1>(context);


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hello word"),
            Padding(padding: EdgeInsets.all(15)),
            Text("${provider.status}")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          provider.socket.emit("emitir-mensaje", {
            "nombre": "flutter",
            "mensaje": "hola desde flutter"
          });
        },
      ),
    );
  }
}
