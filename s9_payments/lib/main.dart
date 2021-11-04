import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s9_payments/pages/home_page.dart';
import 'package:s9_payments/pages/pago_completo.dart';
import 'package:s9_payments/services/stripe_service.dart';

import 'bloc/pagar/pagar_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final StripeService service = new StripeService();
    service.init();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PagarBloc()),
      ],
      child: MaterialApp(
        title: 'Stripe App',
        debugShowCheckedModeBanner: false,
        initialRoute: "home",
        routes: {
          "home": (_) => HomePage(),
          "pago_completo": (_) => PagoCompletoPage(),
        },
        theme: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF284879),
            scaffoldBackgroundColor: const Color(0xff21232A)),
      ),
    );
  }
}
