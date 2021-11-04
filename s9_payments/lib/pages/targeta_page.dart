import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:s9_payments/bloc/pagar/pagar_bloc.dart';
import 'package:s9_payments/widgets/total_pay_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PagoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final tarjeta = context.read<PagarBloc>().state.tarjeta;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pagar"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            context.read<PagarBloc>().add(OnDeseleccionarTarjeta());
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children:[
          Container(),

          Hero(
            tag: tarjeta!.cardHolderName,
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

          Positioned(
            bottom: 0,
            child: TotalPayBUtton()
          )
        ]
      )
   );
  }
}