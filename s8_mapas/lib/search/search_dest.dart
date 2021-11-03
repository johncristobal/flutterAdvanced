
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s8_mapas/models/search_response.dart';
import 'package:s8_mapas/models/search_result.dart';
import 'package:s8_mapas/services/traffic_service.dart';

class SearchDest extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel;
  final TrafficService service;
  final LatLng proximidad;
  final List<SearchResult> historial;

  SearchDest( this.proximidad, this.historial ) : this.searchFieldLabel = 'Buscar...',
  this.service = new TrafficService();

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      IconButton(
        onPressed: () => this.query = "",
        icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {

    final searchRes = SearchResult(cancelo: true);

    return IconButton(
      onPressed: () => this.close(context, searchRes),
      icon: Icon(Icons.arrow_back_ios)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(this.query.length == 0){
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text("Colocar ubicacion manualmente..."),
            onTap: (){
              final searchRes = SearchResult(
                cancelo: false
              );
              
              this.close(context, searchRes);
            },
          ),

          ...this.historial.map((e) => ListTile(
            leading: Icon(Icons.place),
            title: Text(e.nombreDestino ?? ""),
            subtitle: Text(e.description ?? ""),
            onTap: (){
              this.close(context, e);
            },
          )).toList()
        ],
      );
    }

    return _buildResults();
  }

  Widget _buildResults(){
    if(this.query == ""){
      return Container();
    }

    this.service.getSugerenciasPorQuery(this.query.trim(), this.proximidad);

    return StreamBuilder(
      stream: this.service.sugerenciasStream,
      //future: this.service.gerResultsQuery(this.query.trim(), this.proximidad),
      builder: (BuildContext context, AsyncSnapshot<SearchResponse?> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }

        final lugares = snapshot.data!.features;

        if(lugares!.length == 0){
          return ListTile(title: Text("Sin resultados..."),);
        }
        return ListView.separated(
          separatorBuilder: (_ , i ) => Divider(), 
          itemCount: lugares.length,
          itemBuilder: (_, i) {
            final lugar = lugares[i];
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(lugar.textEs ?? ""),
              subtitle: Text(lugar.placeNameEs ?? ""),
              onTap: (){
                final searchRes = SearchResult(
                  cancelo: false,
                  manual: false,
                  position: LatLng(lugar.center![1], lugar.center![0]),
                  nombreDestino: lugar.textEs,
                  description: lugar.placeNameEs
                );
                
                this.close(context, searchRes);
              },
            );
          }, 
        );
      },
    );
  }

}
