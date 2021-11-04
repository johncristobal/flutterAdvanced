import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:s9_payments/bloc/pagar/pagar_bloc.dart';
import 'package:s9_payments/data/tarjetas.dart';
import 'package:s9_payments/helpers/alertas.dart';
import 'package:s9_payments/helpers/fade_in.dart';
import 'package:s9_payments/pages/targeta_page.dart';
import 'package:s9_payments/services/stripe_service.dart';
import 'package:s9_payments/widgets/total_pay_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {

  final StripeService service = new StripeService();

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final bloc = context.read<PagarBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar"),
        actions: [
          IconButton(
            onPressed: () async {

              mostrarLoading(context);

              final resp = await service.pagarNuevaTarjeta(
                amount: bloc.state.montoPagar, 
                currency: bloc.state.moneda
              );
              Navigator.pop(context);
              if(resp.ok){
                await mostrarAlerta(context, "Tarjeta ok", "Todo correcto");
              }else{
                await mostrarAlerta(context, "Algo salio mal", resp.msg);
              }
            },
            icon: Icon(Icons.add))
        ],
      ),
      body: Stack(
        children:[
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.85
              ),
              physics: BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];
                return GestureDetector(
                  onTap: (){
                    context.read<PagarBloc>().add(OnSeleccionarTarjeta(tarjeta));
                    Navigator.push(context, navegarMapaFadeIn(context, PagoPage()));
                  },
                  child: Hero(
                    tag: tarjeta.cardHolderName,
                    child: CreditCardWidget(
                      cardNumber: tarjeta.cardNumberHidden,
                      expiryDate: tarjeta.expiracyDate,
                      cardHolderName: tarjeta.cardHolderName,
                      cvvCode: tarjeta.cvv,
                      showBackView: false,
                      onCreditCardWidgetChange: (value){
                        
                      },
                    ),
                  ),
                );
              }
            ),
          ),

          Positioned(
            bottom: 0,
            child: TotalPayBUtton()
          )
        ]
      )
   );
  }
}