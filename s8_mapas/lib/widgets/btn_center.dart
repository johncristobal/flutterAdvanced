import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:s8_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

class BtnUbicacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final mapaBloc =context.read<MapaBloc>();
    final ubicacionBloc =context.read<MiUbicacionBloc>();

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location),
          color: Colors.black87,
          onPressed: (){
            final destino = ubicacionBloc.state.ubicacion;
            mapaBloc.moverCamara(destino!);
          },
        ),
      ),
    );
  }
}