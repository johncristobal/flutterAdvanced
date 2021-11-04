
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/custommarkers/marker_destino.dart';
import 'package:s8_mapas/custommarkers/marker_inicio.dart';

Future<BitmapDescriptor> getMarkerInicio( int duracion) async {

  final recorder = new PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final markerInicio = new MarkerInicioPainter((duracion / 60).floor());
  markerInicio.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final data = await image.toByteData( format: ImageByteFormat.png);
  
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}

Future<BitmapDescriptor> getMarkerDestino( double distance, String des) async {

  final recorder = new PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(350, 150);

  final markerInicio = new MarkerDestinoPainter( des , distance);
  markerInicio.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final data = await image.toByteData( format: ImageByteFormat.png);
  
  return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
}