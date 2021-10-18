import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:s8_mapas/helpers/helpers.dart';
import 'package:s8_mapas/pages/acceso_gps_page.dart';
import 'package:s8_mapas/pages/mapa_page.dart';


class LoadingPage extends StatefulWidget {

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {

    final gps = await Geolocator.isLocationServiceEnabled();
    
    if(state == AppLifecycleState.resumed){
      if(gps){
        Navigator.pushReplacement(context, navegarMapa(context, MapaPage()));
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return Center(
                child: Text(snapshot.data)
              );
          }else{
            return Center(
                child: CircularProgressIndicator(strokeWidth: 2,)
              );
          }
          
        },
      ),
   );
  }

  Future checkGpsLocation(BuildContext context) async {

    final permiso = await Permission.location.isGranted;
    final gps = await Geolocator.isLocationServiceEnabled();

    if( permiso && gps){
      Navigator.pushReplacement(context, navegarMapa(context, MapaPage()));
      return '';
    }else if(!permiso){
      Navigator.pushReplacement(context, navegarMapa(context, AccesoPage()));
      return "Falta permiso GPS";
    } else {
      return "Active GPS";
    }        
  }
}