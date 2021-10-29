import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/models/driving_response.dart';

class TrafficService { 

  // singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService(){
    return _instance;
  }

  final _dio = new Dio();
  final _url = 'https://api.mapbox.com/directions/v5';
  final _key = 'pk.eyJ1Ijoiam9objk5MDAiLCJhIjoiY2t2Y2ZxcTZiMGJicDJvcWY3ZXkxZGxuNyJ9.4xw5Ix6JLsZo5DqLtHdx8Q';

  Future<DrivingResponse> getCoords( LatLng inicio, LatLng destino) async {
    final coordsString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '$_url/mapbox/driving/$coordsString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this._key,
      'language': 'es'
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }

}