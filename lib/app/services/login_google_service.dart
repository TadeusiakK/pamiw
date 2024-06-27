import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginGoogleService {
  Future<void> signInAndSendData() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // Użytkownik anulował logowanie
      return;
    }

    final GoogleSignInAuthentication googleUserAuthentication =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleUserAuthentication.accessToken,
      idToken: googleUserAuthentication.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
