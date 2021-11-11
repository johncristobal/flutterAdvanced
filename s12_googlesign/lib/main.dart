import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
          actions: [
            IconButton(onPressed: (){

            }, icon: Icon(FontAwesomeIcons.doorOpen))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(                  
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  color:Colors.red,
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                      Text("Google", style: TextStyle(color: Colors.white, fontSize: 17)),
                    ],
                  ),
                  onPressed: (){

                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}