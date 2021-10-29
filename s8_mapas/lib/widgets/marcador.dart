import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/bloc/busqueda/busqueda_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:s8_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:s8_mapas/services/traffic_service.dart';
import 'package:polyline_do/polyline_do.dart';

class Marcador extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return _BuildMarcador();
        }else{
          return Container();
        }
      },
    );
  }   
}

class _BuildMarcador extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return Stack(
      children: [

        Positioned(
          top: 70,
          left: 20,
          child: FadeInLeft(
            duration: Duration(milliseconds: 250),
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: (){
                  context.read<BusquedaBloc>().add(OnDesactivarMarcador());
                },
              ),
            ),
          ),
        ),

        Center(
          child: Transform.translate(
            offset: Offset(0,-10),
            child: BounceInDown(
              from: 200,
              child: Icon(Icons.location_on, size: 40,color: Colors.black87,)
            )
          ),
        ),

        Positioned(
          bottom: 70,
          left: 40,
          child: FadeIn(
            child: MaterialButton(
              minWidth: width - 120,
              child: Text("Confirmar destino", style: TextStyle(color: Colors.white,)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed:(){
                this.calcularDestino(context);
              }
            ),
          ),
        )

      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    final service = new TrafficService();
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = context.read<MapaBloc>().state.ubicacionCentral;

    final resp = await service.getCoords(inicio!, destino!);
    final geometry = resp.routes![0].geometry;
    final duration = resp.routes![0].duration;
    final distance = resp.routes![0].distance;

    final points = Polyline.Decode(
      encodedString: geometry!, 
      precision: 6
    ).decodedCoords;

    final temp = points;
  }
}