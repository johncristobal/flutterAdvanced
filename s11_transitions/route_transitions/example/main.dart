import 'package:flutter/material.dart';
import 'package:custom_route_transitions_john00cristobal/custom_route_transitions_john00cristobal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'page1',
      routes: {
        'page1': (_) => Page1Page(),
        'page2': (_) => Page2Page(),
      },
    );
  }
} 

class Page1Page extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 1"),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.red,
      body: Center(
        child: MaterialButton(
          child: Text("Page 2"),
          color: Colors.white,
          onPressed: (){
            //Navigator.push(context, MaterialPageRoute(builder: (_) => Page2Page()));
            //Navigator.push(context, PageRouteBuilder(pageBuilder: null));

            RouteTransitions(
              context: context,
              child: Page2Page(),
              animtation: AnimationType.fadeIn,
              duration: const Duration(milliseconds: 500)
            );
          },
        ),
     ),
   );
  }
}

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