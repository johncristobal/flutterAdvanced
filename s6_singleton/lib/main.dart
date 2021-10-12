import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s6_singleton/bloc/usuario/usuario_bloc.dart';
import 'package:s6_singleton/pages/pagina1_page.dart';
import 'package:s6_singleton/pages/pagina2_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => new UsuarioBloc())
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: "pagina1",
        routes: {
          "pagina1": (_) => Page1Page(),
          "pagina2": (_) => Page2Page(),
        },
      ),
    );
  }
}