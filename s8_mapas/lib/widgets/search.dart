import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/bloc/busqueda/busqueda_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:s8_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:s8_mapas/helpers/loading.dart';
import 'package:s8_mapas/models/search_result.dart';
import 'package:s8_mapas/search/search_dest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/services/traffic_service.dart';
import 'package:polyline_do/polyline_do.dart' as Poly;

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return Container();
        }else{
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximidad = context.read<MiUbicacionBloc>().state.ubicacion;
            final historial = BlocProvider.of<BusquedaBloc>(context).state.historial;
            final res = await showSearch(
              context: context, 
              delegate: SearchDest(proximidad ?? LatLng(0, 0), historial)
            );
            if(res != null)
              this.retornoBusqueda(context, res);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: double.infinity,
            child: Text("Donde quieres ir...", style: TextStyle(color: Colors.black87),),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future retornoBusqueda(BuildContext context, SearchResult result) async {
    if(result.cancelo) return;
    
    if (result.manual!){
      final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
      busquedaBloc.add(OnActivarMarcador());
      return;
    }

    calculando(context);
    
    final service = TrafficService();
    final bloc = context.read<MapaBloc>();
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    final drivingTrafic = await service.getCoords(inicio!, destino!);

    final geometry = drivingTrafic.routes![0].geometry;
    final duration = drivingTrafic.routes![0].duration;
    final distance = drivingTrafic.routes![0].distance;

    final points = Poly.Polyline.Decode(
      encodedString: geometry!, 
      precision: 6
    ).decodedCoords;

    final List<LatLng> coords = points.map((e) => LatLng(e[0], e[1])).toList();

    bloc.add(OnCrearRuta(
      coords,
      distance ?? 0.0,
      duration ?? 0.0
    ));

    Navigator.of(context).pop();

    final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    busquedaBloc.add(OnAgregarHistorial(result));
  }
}