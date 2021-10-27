import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';

class BtnSeguir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapaBloc = context.read<MapaBloc>();

    return BlocBuilder<MapaBloc, MapaInitial>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(mapaBloc.state.seguir
                  ? Icons.directions_run
                  : Icons.accessibility_new),
              color: Colors.black87,
              onPressed: () {
                mapaBloc.add(OnSeguirUbicacion());
              },
            ),
          ),
        );
      },
    );
  }
}
