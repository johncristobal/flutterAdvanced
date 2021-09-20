import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s2_bandnames/models/band.dart';
import 'package:s2_bandnames/services/socket_service.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    // Band(id: '1', name: 'Metalica', votes: 5),
    // Band(id: '2', name: 'Muse', votes: 4),
    // Band(id: '3', name: 'Nirvana', votes: 3),
    // Band(id: '4', name: 'Coldplay', votes: 1),
  ];

  @override
  void initState() {
    final provider = Provider.of<SocketService>(context, listen: false);
    provider.socket.on("bandas-activas", _handleBandas);
    super.initState();
  }

  _handleBandas( dynamic data){
    this.bands = (data as List).map((e) => Band.fromMap(e)).toList();
    setState(() { });
  }

  @override
  void dispose() {
    final provider = Provider.of<SocketService>(context, listen: false);
    provider.socket.off("bandas-activas");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Bandas"),
        backgroundColor: Colors.white,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: provider.serverStatus == ServerStatus.Online
            ? Icon( Icons.check_circle, color: Colors.blue[300], )
            : Icon( Icons.offline_bolt, color: Colors.red[300], ),
          )
        ],
      ),
      body: Column(
        children: [

          _showGraph(),
          Expanded(
            child: ListView.builder(
              itemCount: bands.length,
              itemBuilder: (context, index) => _bandTile(bands[index])
            ),
          ),
        ],
      ),
      // body: ListView.builder(
      //     itemCount: bands.length,
      //     itemBuilder: (context, index) => _bandTile(bands[index])),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  _showGraph(){
    Map<String, double> dataMap = {
    };

    bands.forEach((b) {
      dataMap.putIfAbsent(b.name, () => b.votes.toDouble());
    });

    return Container(
      width: double.infinity,
      height: 200,
      child: PieChart(dataMap: dataMap));    
  }

  Widget _bandTile(Band band) {

    final provider = Provider.of<SocketService>(context, listen: false);

    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 16),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Delete", style: TextStyle(color: Colors.white),)
        ),
      ),
      onDismissed: ( direction ) => provider.socket.emit("borrar-banda", { "id": band.id }),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          //emit vote
          provider.socket.emit("voto-banda", { "id": band.id });
        },
      ),
    );
  }

  addNewBand() {
    final controller = new TextEditingController();
    if(Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("New..."),
            content: TextField(
              controller: controller,
            ),
            actions: [
              MaterialButton(
                child: Text("Add"),
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandtoList(controller.text)
              )
            ],
          );
        }
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) {
        return CupertinoAlertDialog(
          title: Text("New..."),
          content: CupertinoTextField(
            controller: controller,
          ),
          actions: [
            CupertinoDialogAction(
              child: Text("Add"),
              isDefaultAction: true,
              onPressed: () => addBandtoList(controller.text)
            ),
            CupertinoDialogAction(
              child: Text("Dismiss"),
              isDestructiveAction: true,
              isDefaultAction: true,
              onPressed: () => Navigator.pop(context)
            )
          ],
        );
      }
    );
    
  }

  void addBandtoList(String name){
    if( name.length > 1){
      //add band
      // emitir 'crear-banda'
      //{ name: name }
      final provider = Provider.of<SocketService>(context, listen: false);
      provider.socket.emit("crear-banda", { "name": name }); 
    }

    Navigator.pop(context);
  }
}
