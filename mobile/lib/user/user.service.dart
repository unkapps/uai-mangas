import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leitor_manga/config/dio_config.dart';
import 'package:leitor_manga/firebase/notifications/firebase_notifications.service.dart';

class UserService {
  static final getIt = GetIt.instance;
  final FirebaseNotifications firebaseNotifications =
      getIt<FirebaseNotifications>();

  final FirebaseAuth _firebaseAuth;
  final FacebookLogin _facebookLogin;
  final GoogleSignIn _googleSignIn;

  UserService(
      {FirebaseAuth firebaseAuth,
      FacebookLogin facebookLogin,
      GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookLogin = facebookLogin ?? FacebookLogin(),
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  Future<FirebaseUser> signInWithFacebook() async {
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final facebookAuthCred = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        try {
          await _firebaseAuth.signInWithCredential(facebookAuthCred);

          await _sendTokenToBack();
        } catch (_) {
          await signOut();
          rethrow;
        }
        return _firebaseAuth.currentUser();
      case FacebookLoginStatus.cancelledByUser:
        return null;
      case FacebookLoginStatus.error:
        return null;
      default:
        return null;
    }
  }

  Future<String> getToken() async {
    var user = await _firebaseAuth.currentUser();

    if (user != null) {
      try {
        var idToken = await user.getIdToken();

        return idToken.token;
      } catch (_) {}
    }

    return null;
  }

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      await _sendTokenToBack();
      return _firebaseAuth.currentUser();
    } catch (_) {
      await signOut();
      rethrow;
    }
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _facebookLogin.logOut(),
      firebaseNotifications.firebaseMessaging.deleteInstanceID(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await getUser();
    return currentUser != null;
  }

  Future<FirebaseUser> getUser() async {
    return _firebaseAuth.currentUser();
  }

  void _sendTokenToBack() async {
    try {
      var fcmToken = await firebaseNotifications.firebaseMessaging.getToken();
      final dio = await DioConfig.withToken();
      await dio.post('/auth/firebase', queryParameters: {
        'fcmToken': fcmToken,
      });
    } catch (err) {
      debugPrint(err.toString());
      rethrow;
    }
  }
}
