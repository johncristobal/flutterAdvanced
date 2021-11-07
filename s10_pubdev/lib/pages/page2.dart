import 'package:flutter/material.dart';


class Page2Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.green,
      body: Center(
        child: Text('Page 2'),
     ),
   );
  }
}