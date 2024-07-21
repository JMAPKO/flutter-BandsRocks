import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/ProyectoUnoV3/pages/StatusPage3.dart';
import 'package:undemy_project_1/ProyectoUnoV3/pages/home3.dart';
import 'package:undemy_project_1/ProyectoUnoV3/service/socket.dart';

void main(){
  runApp(_app());
}

class _app extends StatelessWidget{

  @override
  Widget build (BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create:(_) => socketSERV())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Socket client",
        initialRoute: "home",
        routes: {
          "home": (_) => Home3(),
          "status": (_) => statusPage3()
        },
      ),
    );
  }
}