import 'package:dio/dio.dart';
import 'package:s9_payments/models/payment_intent_response.dart';
import 'package:s9_payments/models/stripe_response.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeService {

  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  String _paymentApiUrl = "https://api.stripe.com/v1/payment_intents";
  static String _key = "sk_test_51Js9eEAqSQY3RNiQn3nEqDdNcVCDGVpah49xIxP7PlQDMEDjhTA29tV5n21gZecaNf04Ku66wv2LFNbMa6KJHmxK00KZLGi9AJ";
  String _published = "pk_test_51Js9eEAqSQY3RNiQUm6gqS7wwFlJMGmkYbjv46xIIbV1clvnUsUGAjaER2C0VxcXeVMvIpEiYQfYYsZIxvWJilAL00zvIKsO55";

  final headers = new Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {
      "Authorization": "Bearer ${StripeService._key}"
    }
  );

  void init(){
    StripePayment.setOptions(StripeOptions(
      publishableKey: _published,      
      merchantId: "test",
      androidPayMode: 'test')
    );
  }

  Future<StripeCustomResponse> pagarTarjetaExistente({
    required String amount,
    required String currency,
    required CreditCard card,
  }) async {

    try{

      final method = await StripePayment.createPaymentMethod(
        PaymentMethodRequest( card: card )
      );

      final resp = await _realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: method
      );

      return resp;
      
    }catch(err){
      return StripeCustomResponse(ok: false, msg: err.toString());
    }
  }

  Future<StripeCustomResponse> pagarNuevaTarjeta({
    required String amount,
    required String currency,
  }) async {
    try{

      final method = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      final resp = await _realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: method
      );

      return resp;
      
    }catch(err){
      return StripeCustomResponse(ok: false, msg: err.toString());
    }
  }

  Future<StripeCustomResponse> pagarAppleGoogle({
    required String amount,
    required String currency,
  }) async {
    try{

      final newAmount = double.parse(amount) / 100;
      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency, 
          totalPrice: amount
        ),
        applePayOptions: ApplePayPaymentOptions(
          countryCode: "US",
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: "Producto 1",
              amount: "$newAmount"
            )
          ]
        )
      );

      final method = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            token: token.tokenId
          )
        )
      );

      await StripePayment.completeNativePayRequest();

      final resp = await _realizarPago(
        amount: amount,
        currency: currency,
        paymentMethod: method
      );

      return resp;

    }catch(err){
      return StripeCustomResponse(ok: false, msg: err.toString());
    }
  }

  Future<PaymentIntentResponse> _crearPaymentIntent({
    required String amount,
    required String currency,
  })async{

    try{

      final dio = Dio();
      final data = {
        "amount" : amount,
        "currency": currency,
      };

      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headers
      );

      return PaymentIntentResponse.fromJson(resp.data);

    }catch(err){
      print(err);
      return PaymentIntentResponse(status: "400");
    }

  }

  Future<StripeCustomResponse> _realizarPago({
    required String amount,
    required String currency,
    required PaymentMethod paymentMethod,
  }) async{

    try{
      final resp = await _crearPaymentIntent(
        amount: amount,
        currency: currency
      );

      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: resp.clientSecret,
          paymentMethodId: resp.id
        )
      );

      if(paymentResult.status == "succeeded"){
        return StripeCustomResponse(ok: true);
      }else{
        return StripeCustomResponse(ok: false, msg: paymentResult.status ?? "Fallo...");
      }


    }catch(err){
      return StripeCustomResponse(ok: false, msg: err.toString());
    }
  }
}