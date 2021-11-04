import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:s9_payments/bloc/pagar/pagar_bloc.dart';
import 'package:s9_payments/helpers/alertas.dart';
import 'package:s9_payments/services/stripe_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayBUtton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final bloc = context.read<PagarBloc>().state;

    return Container(
      width: size.width,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Total", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text("${bloc.montoPagar} ${bloc.moneda}", style: TextStyle(fontSize: 20)),
            ],
          ),
          BlocBuilder<PagarBloc, PagarState>(
            builder: (context, state) {
              return _BtnPay( state );
            },
          ),
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {

  final PagarState state;

  const _BtnPay(this.state);

  @override
  Widget build(BuildContext context) {
    return state.tarjetaActiva
    ? buldButtonTarjeta(context)
    : buildAppleGooglePay(context);
  }

  Widget buldButtonTarjeta(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(FontAwesomeIcons.solidCreditCard,color: Colors.white),
          SizedBox(width: 8,),
          Text("Pagar", style: TextStyle(color: Colors.white, fontSize: 22),)
        ],
      ),
      onPressed: () async {
        final state = context.read<PagarBloc>().state;
        final service = StripeService();
        final mesanio = state.tarjeta!.expiracyDate.split("/");

        mostrarLoading(context);

        final resp = await service.pagarTarjetaExistente(
          amount: state.montoPagar,
          currency: state.moneda,
          card: CreditCard(
            number: state.tarjeta!.cardNumber,
            expMonth: int.parse(mesanio[0]),
            expYear: int.parse(mesanio[1])
          )
        );

         Navigator.pop(context);

          if(resp.ok){
            await mostrarAlerta(context, "Tarjeta ok", "Todo correcto");
          }else{
            await mostrarAlerta(context, "Algo salio mal", resp.msg);
          }

        
      },

    );
  }

  Widget buildAppleGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(
            Platform.isIOS ?
            FontAwesomeIcons.apple :
            FontAwesomeIcons.google,
            color: Colors.white),
          Text("Pay", style: TextStyle(color: Colors.white, fontSize: 22),)
        ],
      ),
      onPressed: () async {
        final state = context.read<PagarBloc>().state;
        final service = StripeService();

        final resp = await service.pagarAppleGoogle(
          amount: state.montoPagar,
          currency: state.moneda,
        );

        if(resp.ok){
          await mostrarAlerta(context, "Tarjeta ok", "Todo correcto");
        }else{
          await mostrarAlerta(context, "Algo salio mal", resp.msg);
        }
      },
    );
  }
}
