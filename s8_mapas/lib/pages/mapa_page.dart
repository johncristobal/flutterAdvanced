import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:s8_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/widgets/btn_center.dart';
import 'package:s8_mapas/widgets/btn_miruta.dart';
import 'package:s8_mapas/widgets/btn_seguir.dart';
import 'package:s8_mapas/widgets/marcador.dart';
import 'package:s8_mapas/widgets/search.dart';

class MapaPage extends StatefulWidget {

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  //Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    context.read<MiUbicacionBloc>().iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    context.read<MiUbicacionBloc>().cancelarSeguimiento();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (context, state){
              return crearMapa(state);
            }
          ),
          Positioned(
            top: 15,
            child: SearchBar()
          ),
          
          Marcador()
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),
          BtnMiRuta(),
          BtnSeguir()

        ],
      ),
   );
  }

  Widget crearMapa(MiUbicacionState state){
    final mapBloc = BlocProvider.of<MapaBloc>(context);
    if(!state.existeUbicacion) return Center(child: Text("Ubicando..."));

    mapBloc.add(OnLocationUpdate( state.ubicacion! ));

    final camertapos = CameraPosition(
      target: state.ubicacion ?? LatLng(0, 0),
      zoom: 15,
    );

    return BlocBuilder<MapaBloc, MapaInitial>(
      builder: (context, state) {
        return  GoogleMap(
          initialCameraPosition: camertapos,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          onMapCreated: mapBloc.initMap,
          polylines: (mapBloc.state.polylines != null) ? mapBloc.state.polylines!.values.toSet() : Set(),
          onCameraMove: (CameraPosition pos){
            mapBloc.add(OnMovioMapa(pos.target));
          },
        );
      },
    );
  }
}
