import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s8_mapas/bloc/mapa/mapa_bloc.dart';
import 'package:s8_mapas/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/widgets/btn_center.dart';

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
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: (context, state){
          return crearMapa(state);
        }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BtnUbicacion(),

        ],
      ),
   );
  }

  Widget crearMapa(MiUbicacionState state){
    final mapBloc = BlocProvider.of<MapaBloc>(context);
    if(!state.existeUbicacion) return Center(child: Text("Ubicando..."));

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: state.ubicacion ?? LatLng(0, 0),
        zoom: 15,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: mapBloc.initMap,
    );
  }
}
