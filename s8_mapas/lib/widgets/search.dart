import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:s8_mapas/bloc/busqueda/busqueda_bloc.dart';
import 'package:s8_mapas/models/search_result.dart';
import 'package:s8_mapas/search/search_dest.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if(state.seleccionManual){
          return Container();
        }else{
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context));
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final res = await showSearch(
              context: context, 
              delegate: SearchDest()
            );
            this.retornoBusqueda(context, res!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: double.infinity,
            child: Text("Donde quieres ir...", style: TextStyle(color: Colors.black87),),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0,5)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result){
    if(result.cancelo) return;
    
    if (result.manual!){
      final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
      busquedaBloc.add(OnActivarMarcador());
      return;
    }
  }
}