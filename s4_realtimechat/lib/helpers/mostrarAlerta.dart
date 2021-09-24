import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta( BuildContext context, String title, String msg ){

  if(Platform.isAndroid){
    return showDialog(
      context: context, 
      builder: ( _ ) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("ok"),
            elevation: 1,
            textColor: Colors.blue
          )
        ],
      )
    );
  }

  showCupertinoDialog(
    context: context, 
    builder: ( _ ) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("ok"),
        )
      ],
    )
  );
}