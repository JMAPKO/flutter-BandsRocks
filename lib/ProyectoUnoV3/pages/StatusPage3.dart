
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/ProyectoUnoV3/service/socket.dart';

class statusPage3 extends StatelessWidget{
  
  @override
  Widget build (BuildContext context){

    final provider1 = Provider.of<socketSERV>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hola!"),
            Text("El estado del servidor es: ${provider1.estado}")
          ],
        ),        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.chat, color: Colors.white,),
        onPressed: (){
            provider1.socket.emit("saludo", {"emisor":"flutter", "mensaje":"hola mundo!"});
        },
      ),
    );
  }
}