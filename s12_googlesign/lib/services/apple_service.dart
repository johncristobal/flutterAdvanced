import 'dart:io';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:http/http.dart' as http;

class AppleSignInService{

  static void signIn() async {
    try{
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      print(credential);
      print(credential.authorizationCode);

      final singAppelEP = Uri(
        scheme: "https",
        host: "flutteradvancedjohn.herokuapp.com",
        path: "/sign_in_with_apple",
        queryParameters: {
          'code': credential.authorizationCode,
          'firstName': credential.givenName,
          'lastName': credential.familyName,
          'useBundleId': Platform.isIOS ? "true" : 'false',
          if( credential.state != null ) 'state' : credential.state
        }
      );

      final resp = await http.post(singAppelEP);
      print(resp.body);
    }catch(err){
      print(err);
    }


  }
}