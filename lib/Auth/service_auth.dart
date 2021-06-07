import 'package:app_math/Services/service_data_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ServiceAuth {
  // CONSTRUCTOR ---------------------------------------------------------------
  static final ServiceAuth _singleton = ServiceAuth._internal();
  factory ServiceAuth() => _singleton;
  ServiceAuth._internal();

  // VARIABLES ---------------------------------------------------------------
  GoogleSignInAccount? signInAccount;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // FUNCTIONS ---------------------------------------------------------------
  Future<bool> login(TypeLogin typeLogin) async {
    ServiceDataUser serviceDataUser = new ServiceDataUser();
    if (typeLogin == TypeLogin.Anonymous) {
      await serviceDataUser.loadUserData(typeLogin: typeLogin);
      return true;
    }
    try {
      signInAccount = await _googleSignIn.signIn();
      if (await isConnect) {
        await serviceDataUser.loadUserData(
          userId: signInAccount!.id,
          typeLogin: typeLogin,
        );
        return true;
      }
    } catch (error) {
      print(error);
    }
    return false;
  }

  Future<bool> get isConnect async {
    return await _googleSignIn.isSignedIn();
  }

  disconnect() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      print(e);
    }
  }
}
