import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterGoogleService {
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

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await sendFirstUserDataToApi(userCredential.user!);
  }

  Future<void> sendFirstUserDataToApi(User user) async {
    Response response;
    Dio dio = Dio();

    String apiUrl =
        'https://us-central1-pamiw-projekt-529bb.cloudfunctions.net/users/${user.uid}';

    response = await dio.post(apiUrl, data: {
      "name": user.displayName,
      "password": "Google Password",
      "email": user.email,
      "tasks": [],
      "eachDayProgress": [
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0},
        {"eachDayProgress": 0}
      ],
      "checkedTasks": 0,
    });

    // ignore: avoid_print
    print('API Response: ${response.data}');
  }
}
