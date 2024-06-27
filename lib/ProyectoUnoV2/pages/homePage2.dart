import 'package:flutter/material.dart';
import '../models/bandasRock.dart';

class homePage2 extends StatefulWidget {
  @override
  State<homePage2> createState() => _State();
}

class _State extends State<homePage2> {

  List<bandasRock> bandas = [
    bandasRock(ID: "xasdad", name: "SUM 41", votos: 5),
    bandasRock(ID: "fkoasdsa", name: "Metalica", votos: 4),
    bandasRock(ID: "sdafr", name: "Breaking benjamin", votos: 5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandas de rock", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),),
        backgroundColor: Colors.white,
      ),

      body: ListView.builder(
          itemCount: bandas.length,
          itemBuilder: (context, i) =>
             _ListaBandas(bandas[i])
      ),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, "status"),
              child: Text("STATUS")
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          FloatingActionButton(
            onPressed: _nuevaBanda,
            child: Icon(Icons.add, color: Colors.white,),
          ),
        ],
      )


    );
  }

  _ListaBandas(bandasRock banda) {
    return ListTile(
            leading: CircleAvatar(
              child: Text(banda.name.substring(0,2)),
            ),
            title: Text(banda.name),
            trailing: Text("${banda.votos}"),
            onTap: (){votar(banda);},
          );
  }

  _nuevaBanda(){
    final _control = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) =>
        AlertDialog(
        title: Text("Agregar nueva banda"),
        content: TextField(
          controller: _control,
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                  child: Text("Cerrar"),
                  onPressed: (){
                    Navigator.pop(context);
                  }
              ),
              MaterialButton(
                  child: Text("agregar"),
                  onPressed: (){
                    agregarBanda(_control.text);
                    Navigator.pop(context);
                  }
              ),
            ],
          )

        ],
      ),
    );
  }

  void agregarBanda(String banda) {
    setState(() {
      bandas.add(bandasRock(ID: DateTime.now().toString(), name: banda, votos: 1));
    });
  }

  votar(bandasRock banda) {
    setState(() {
      banda.votos++;
    });
  }
}
