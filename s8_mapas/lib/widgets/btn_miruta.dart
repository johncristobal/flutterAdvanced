import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:s8_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class BtnMiRuta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapaBloc =context.read<MapaBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.more_horiz),
          color: Colors.black87,
          onPressed: (){
           mapaBloc.add( OnMarcarRecorrido());
          },
        ),
      ),
    );
  }
}