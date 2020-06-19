import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class UserService {
  final FirebaseAuth _firebaseAuth;
  final FacebookLogin _facebookLogin;

  UserService({FirebaseAuth firebaseAuth, FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookLogin = facebookLogin ?? FacebookLogin();

  Future<FirebaseUser> signInWithFacebook() async {
    _facebookLogin.loginBehavior = FacebookLoginBehavior.webViewOnly;

    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final facebookAuthCred = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        await _firebaseAuth.signInWithCredential(facebookAuthCred);
        return _firebaseAuth.currentUser();
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.error:
        return null;
      default:
        return null;
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _facebookLogin.logOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await getUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return _firebaseAuth.currentUser();
  }
}
