import 'package:flutter/material.dart';
import 'package:s8_mapas/custommarkers/marker_destino.dart';
import 'package:s8_mapas/custommarkers/marker_inicio.dart';

class TestMarker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerDestinoPainter('Mi casa por algun laod esta aqui', 20 ),
          ),
        ),
      ),
    );
  }
}