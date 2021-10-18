import 'package:flutter/material.dart';
import 'package:s8_mapas/pages/acceso_gps_page.dart';
import 'package:s8_mapas/pages/loading_page.dart';
import 'package:s8_mapas/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        'mapa': (_ ) => MapaPage(),
        'loading': (_ ) => LoadingPage(),
        'acceso': (_ ) => AccesoPage(),
      },
    );
  }
}