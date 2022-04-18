
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(scopes: ['https://mail.google.com/']);
  static Future<GoogleSignInAccount?> login() async {
    if(await _googleSignIn.isSignedIn()){
      return _googleSignIn.currentUser;
    } else {
      return await _googleSignIn.signIn();
    }
  }

  static void logOut() {
    _googleSignIn.disconnect();
  }

}