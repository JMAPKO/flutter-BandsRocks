import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/ProyectoUnoV2/pages/homePage2.dart';
import 'package:undemy_project_1/ProyectoUnoV2/pages/statusPage.dart';
import 'package:undemy_project_1/ProyectoUnoV2/service/socket.dart';

void main() {
  runApp(_app2());
}

class _app2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService() ,)
      ],
      child: MaterialApp(
        title: "Coneccion con socket",
        theme: ThemeData(useMaterial3: false),
        initialRoute: "Home",
        routes: {
          "Home": (_) => homePage2(),
          "status": (_) => statusPage()
        }
      ),
    );
  }
}
