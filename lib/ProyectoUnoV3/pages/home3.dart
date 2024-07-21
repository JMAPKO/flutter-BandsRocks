import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:undemy_project_1/ProyectoUnoV3/service/socket.dart';
import 'package:undemy_project_1/proyectoUno/models/Banda.dart';

class Home3 extends StatefulWidget {

  @override
  State<Home3> createState() => _State();
}

class _State extends State<Home3> {

  //lISTA DE BANDAS
  List<Banda> bands = [
    Banda(name: "Linkin Park", id: "ASD1", voto: 5),
    Banda(name: "Breaking Benjamin", id: "ads13", voto: 2),
    Banda(name: "Sum 41", id: "ASGDF15", voto: 4)
  ];


  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<socketSERV>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("RocksBands", style: TextStyle(fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.grey[100],
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (provider.estado == status.online ?
            Icon(Icons.check_circle, color: Colors.green,) :
            (provider.estado == status.offline ? 
                Icon(Icons.build_circle_rounded, color: Colors.red,) :
                Icon(Icons.downloading)
            )
            
            )
          )
        ],
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i){
            return Dismissible(
              key: Key(bands[i].id),
              child: _listaBandas(bands[i]),
              background: Container(
                color: Colors.red[200],
                alignment: Alignment.center,
                //padding: EdgeInsets.symmetric(horizontal: 20),
                child: Icon(Icons.delete, color: Colors.white,),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                final removedBand = bands[i].name;
                setState(() {
                  bands.removeAt(i);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("La banda: ${removedBand} - FUE ELIMINADA"),
                      action: SnackBarAction(label: "cerrar", onPressed: ()=> ScaffoldMessenger.of(context).hideCurrentSnackBar()),
                    )
                );
              },
            );

          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _newBand,
      ),
    );
  }

  _listaBandas(Banda band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.name.substring(0,2)),
        backgroundColor: Colors.blue[100],
      ),
      title: Text(band.name),
      trailing: Text("${band.voto}"),
      onTap: () => _votar(band),
    );
  }

  _newBand() {
    final _controller = TextEditingController();
    /*if(!Platform.isAndroid) {*/ // si es android
      showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                title: Text("Agregar una nueva Banda?"),
                content: TextField(
                  controller: _controller,
                ),
                actions: [
                  MaterialButton(
                      child: Text("cerrar"),
                      onPressed: () => Navigator.pop(context)
                  ),
                  MaterialButton(
                      child: Text("Agregar"),
                      onPressed: () => _AddBand(_controller.text)
                  ),
                ],
              )
      );
    }
    /*showCupertinoDialog(
          context: context,
          builder: (_) =>
              CupertinoAlertDialog(
                title: Text("Agregar nueva banda"),
                content: CupertinoTextField(
                  controller: _controller,
                ),
                actions: [
                  CupertinoDialogAction(
                      child: Text("Cerrar"),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                  ),
                  CupertinoDialogAction(
                    child: Text("Add"),
                    onPressed: () => _AddBand(_controller.text)
                  ),
                ],
              )
      );*/
  //}


  _AddBand(String name) {
    if (name.length > 1){
      bands.add(Banda(name: name, id: DateTime.now().toString(), voto: 1));
      setState(() {});
    }
    Navigator.pop(context);
  }

  void _votar(Banda band) {
    setState(() {
      band.voto++;
    });
  }
}
