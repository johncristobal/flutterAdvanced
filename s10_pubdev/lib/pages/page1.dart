import 'package:flutter/material.dart';
import 'package:s10_pubdev/helpers/route_transitions.dart';
import 'package:s10_pubdev/pages/page2.dart';


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