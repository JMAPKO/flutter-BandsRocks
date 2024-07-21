import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/proyectoUno/pages/HomePage1.dart';
import 'package:undemy_project_1/proyectoUno/pages/StatusPage.dart';
import 'package:undemy_project_1/proyectoUno/service/socket.dart';

void main() {
  runApp(_app());
}

class _app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => socketService1(),)
      ],
      child: MaterialApp(
        title: "App - prueba",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: false),
        initialRoute: "Home",
        routes: {
          "Home": (_) => HomePage1(),
          "status": (_) => StatusPage()
        },
      ),
    );
  }
}
