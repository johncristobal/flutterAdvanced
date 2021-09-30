import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s6_singleton/pages/pagina1_page.dart';
import 'package:s6_singleton/pages/pagina2_page.dart';
import 'package:s6_singleton/services/usuario_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UsuarioService())
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