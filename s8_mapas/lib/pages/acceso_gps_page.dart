
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class AccesoPage extends StatefulWidget {

  @override
  State<AccesoPage> createState() => _AccesoPageState();
}

class _AccesoPageState extends State<AccesoPage> with WidgetsBindingObserver{

  bool popup = false;

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

    print(state);
    if(state == AppLifecycleState.resumed && !popup){
      if(await Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, "loading");
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Es necesario el GPS"),

            MaterialButton(
              child: Text("Solicitar acceso", style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                popup = true;
                final status = await Permission.location.request();
                await this.accesoGPS(status);
                popup = false;
              }
            )
          ],
        ),
     ),
   );
  }

  Future accesoGPS( PermissionStatus status) async {
    print(status);
    switch (status) {
      case PermissionStatus.granted:
        await Navigator.pushReplacementNamed(context, "loading");
      break;
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
        openAppSettings();
        break;
      default:
    }
  }
}