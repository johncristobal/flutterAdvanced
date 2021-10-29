
import 'package:flutter/material.dart';
import 'package:s8_mapas/models/search_result.dart';

class SearchDest extends SearchDelegate<SearchResult>{

  @override
  final String searchFieldLabel;
  SearchDest() : this.searchFieldLabel = 'Buscar...';

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
    return Text("aaa");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
       )
     ],
   );
  }

}
