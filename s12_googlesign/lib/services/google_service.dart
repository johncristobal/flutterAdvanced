import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
    ]
  );

  static Future<GoogleSignInAccount?> signGoogle() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      final googekey = await account!.authentication;
      print(googekey.idToken);

      

      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}

