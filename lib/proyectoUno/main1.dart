import 'package:flutter/material.dart';
import 'package:undemy_project_1/proyectoUno/pages/HomePage1.dart';
import 'package:undemy_project_1/proyectoUno/pages/StatusPage.dart';
import 'package:undemy_project_1/proyectoUno/pages/status.dart';

void main() {
  runApp(_app());
}

class _app extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App - prueba",
      theme: ThemeData(useMaterial3: false),
      initialRoute: "status",
      routes: {
        "Home": (_) => HomePage1(),
        "status": (_) => StatusPage()
      },
    );
  }
}
