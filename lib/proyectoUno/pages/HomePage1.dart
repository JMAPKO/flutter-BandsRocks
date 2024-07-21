import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:undemy_project_1/proyectoUno/models/Banda.dart';
import 'package:undemy_project_1/proyectoUno/service/socket.dart';

class HomePage1 extends StatefulWidget {

  @override
  State<HomePage1> createState() => _State();
}

class _State extends State<HomePage1> {

  //lISTA DE BANDAS
  List<Banda> bands = [
    /*Banda(name: "Linkin Park", id: "ASD1", voto: 5),
    Banda(name: "Breaking Benjamin", id: "ads13", voto: 2),
    Banda(name: "Sum 41", id: "ASGDF15", voto: 4)*/
  ];
  
  @override
  void initState() {
    final providerStatus = Provider.of<socketService1>(context, listen: false);
    providerStatus.socket.on("bandas-activas", (_BandMap)
    );
    super.initState();
  }

  _BandMap(dynamic payload){
    this.bands = (payload as List).
    map((banda) => Banda.isfromMap(banda)).toList(); // Mapeamos el dato del servidor. Es muy importante que los Modelos del servidor sean los mismos (el texto) el de los del cliente. Mas si es una lista
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    final providerStatus = Provider.of<socketService1>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("RocksBands", style: TextStyle(fontSize: 20, color: (providerStatus.status == statusServices.Online) ? Colors.black87 : Colors.red, fontWeight: FontWeight.bold),),
        backgroundColor: (providerStatus.status == statusServices.Online) ? Colors.white : Colors.yellow,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (providerStatus.status == statusServices.Online) ?
            Icon(Icons.check_circle, color: Colors.blue,) : Icon(Icons.close, color: Colors.red,)
          )
        ],
      ),
      body: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: _GraficaBAND(),
            ),

            Expanded(// SIRVER PARA COLOCAR UN LISTVIEW EN UNA COLUM
              child: ListView.builder(
                  itemCount: bands.length,
                  itemBuilder: (context, i){
                    return  _listaBandas(bands[i]);
              
                          /*setState(() {
                            bands.removeAt(i);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text("La banda: ${removedBand} - FUE ELIMINADA"),
                              action: SnackBarAction(label: "cerrar", onPressed: ()=> ScaffoldMessenger.of(context).hideCurrentSnackBar()),
                            )
                          );*/
              
                          //METODO NUEVO
                          //providerStatus.socket.emit("borrar", {"id": removedBand.id});
                  }
              ),
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _newBand,
      ),
    );
  }

  _listaBandas(Banda band) {

    final provider = Provider.of<socketService1>(context, listen: false);

    return Dismissible(
       key: Key(band.id),
       background: Container(
          color: Colors.red[200],
         alignment: Alignment.center,
          //padding: EdgeInsets.symmetric(horizontal: 20),
         child: Icon(Icons.delete, color: Colors.white,),
        ),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
              provider.socket.emit("borrar", {"id": band.id});
        },
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.nAme.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.nAme),
        trailing: Text("${band.vote}"),
        onTap: () => _votar(band),
      ),
    );
  }

  _newBand() {
    final _controller = TextEditingController();
   /* if(!Platform.isAndroid) {*/
      /*return*/ showDialog(
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
      /*bands.add(Banda(nAme: name, id: DateTime.now().toString(), vote: 1));
      setState(() {});//VIEJO METODO*/

      //NUEVO METODO
    final provider2 = Provider.of<socketService1>(context, listen: false);
    provider2.socket.emit("agregar-band", {"name": name});

    }
    Navigator.pop(context);

  }

  void _votar(Banda band) {
    setState(() {
      //band.vote++; SISTEMA VIEJO PARA VOTAR
      final provider = Provider.of<socketService1>(context, listen: false);
      provider.socket.emit("votar", {"id": band.id});
    });
  }

    _GraficaBAND() {
    Map<String, double> dataMap = {};
    bands.forEach((bandita){
      dataMap.putIfAbsent(bandita.nAme, () => bandita.vote.toDouble());
    });
    return Container(
      height: 250,
      width: double.infinity,
      child: PieChart(
          dataMap: dataMap,
        animationDuration: Duration(milliseconds: 800),
        chartLegendSpacing: 32,
        chartRadius: MediaQuery.of(context).size.width / 3.2,
        initialAngleInDegree: 0,
        chartType: ChartType.ring,
        ringStrokeWidth: 32,
        centerText: "BANDAS",
        legendOptions: LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValueBackground: true,
          showChartValues: true,
          showChartValuesInPercentage: true,
          showChartValuesOutside: true,
          decimalPlaces: 1,
        ),
      ),
    );
  }
}
