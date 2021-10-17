import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:s6_singleton/pages/pagina1_page.dart';
import 'package:s6_singleton/pages/pagina2_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: "/pagina1",
      getPages: [
        GetPage(name: '/pagina1', page: () => Page1Page()),
        GetPage(name: '/pagina2', page: () => Page2Page())
      ],
      // routes: {
      //   "pagina1": (_) => Page1Page(),
      //   "pagina2": (_) => Page2Page(),
      // },
    );
  }
}