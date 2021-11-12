import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:s12_googlesign/services/apple_service.dart';
import 'package:s12_googlesign/services/google_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
          actions: [
            IconButton(
              onPressed: () async {
                GoogleSignInService.signOut();
            }, icon: Icon(FontAwesomeIcons.doorOpen))
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(                  
                  splashColor: Colors.transparent,
                  minWidth: double.infinity,
                  color:Colors.red,
                  shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                      Text("Google", style: TextStyle(color: Colors.white, fontSize: 17)),
                    ],
                  ),
                  onPressed: () async {
                    await GoogleSignInService.signGoogle();
                  },
                ),

                SignInWithAppleButton(
                  onPressed: () async {
                     AppleSignInService.signIn();
                    // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                    // after they have been validated with Apple (see `Integration` section for more information on how to do this)
                  },
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}