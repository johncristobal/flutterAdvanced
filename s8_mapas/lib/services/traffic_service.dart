import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/helpers/debouncer.dart';
import 'package:s8_mapas/models/driving_response.dart';
import 'package:s8_mapas/models/reverse_response.dart';
import 'package:s8_mapas/models/search_response.dart';

class TrafficService { 

  // singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService(){
    return _instance;
  }

  final _dio = new Dio();

  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500 ));
  final StreamController<SearchResponse> _sugerenciasStreamController = new StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get sugerenciasStream => this._sugerenciasStreamController.stream;

  final _url = 'https://api.mapbox.com/directions/v5';
  final _urlDic = 'https://api.mapbox.com/geocoding/v5';
  final _key = 'pk.eyJ1Ijoiam9objk5MDAiLCJhIjoiY2tmOTRqZjB1MGlpejJ3cnF3NzN5bDlrZSJ9.x0mW4UksX3xWQq4cTAbL5g';

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

  Future<SearchResponse?> gerResultsQuery( String busqueda, LatLng proximity ) async {
    try{
      final url = '$_urlDic/mapbox.places/$busqueda.json';

      final resp = await this._dio.get(url, queryParameters: {
        //'proximity': '${proximity.latitude},${proximity.longitude}',
        'access_token': this._key,
        'language': 'es',
        'autocomplete': 'true',
        'country': 'mx'
      });

      final data = searchResponseFromJson(resp.data);

      return data;
    
    }catch(err){
      print(err);
      return SearchResponse( features: [] );
    }
  }

  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await this.gerResultsQuery(value, proximidad);
      this._sugerenciasStreamController.add(resultados!);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 
  }

  Future<ReverseQueryResponse> getCoordsQuery( LatLng destino ) async {

    final coordsString = '${destino.longitude},${destino.latitude}.json';
    final url = '$_urlDic/mapbox.places/$coordsString';

    final resp = await this._dio.get(url, queryParameters: {
      'access_token': this._key,
      'language': 'es'
    });

    final data = reverseQueryResponseFromJson(resp.data);

    return data;
  }
}
