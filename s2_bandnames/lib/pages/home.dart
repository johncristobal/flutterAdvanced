import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:s2_bandnames/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Muse', votes: 4),
    Band(id: '3', name: 'Nirvana', votes: 3),
    Band(id: '4', name: 'Coldplay', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bandas"),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
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
      onDismissed: ( direction ){
        
      },
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
        onTap: () {},
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
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() { });
    }

    Navigator.pop(context);
  }
}
