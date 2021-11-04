
import 'package:flutter/material.dart';

mostrarLoading(BuildContext context){

  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (_) => AlertDialog(
      title: Text("Espere..."),
      content: LinearProgressIndicator(),
    ));
}

mostrarAlerta(BuildContext context, String title, String msg){
  showDialog(
    barrierDismissible: false,
    context: context, 
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        MaterialButton(
          child: Text("oK"),
          onPressed: () => Navigator.of(context).pop()
        )
      ],
    ));
}