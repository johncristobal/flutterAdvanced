import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void calculando(BuildContext context){

  if(Platform.isAndroid){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Espere de favor"),
        content: Text("Calculando..."),
      )
    );
  } else {
    showCupertinoDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Text("Espere de favor"),
        content: CupertinoActivityIndicator(),
      )
    );
  }

}