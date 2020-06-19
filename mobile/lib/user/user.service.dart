import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:leitor_manga/config/dio_config.dart';

class UserService {
  static final Dio dio = DioConfig.dio;

  final FirebaseAuth _firebaseAuth;
  final FacebookLogin _facebookLogin;

  UserService({FirebaseAuth firebaseAuth, FacebookLogin facebookLogin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _facebookLogin = facebookLogin ?? FacebookLogin();

  Future<FirebaseUser> signInWithFacebook() async {
    final result = await _facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final facebookAuthCred = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
            try {
        var authResult =
            await _firebaseAuth.signInWithCredential(facebookAuthCred);
        
          await _sendTokenToBack((await authResult.user.getIdToken()).token);
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

  void _sendTokenToBack(String tokenId) async {
    try {
      await dio.post('/auth/firebase', data: {
        'tokenId': tokenId,
      });
    } catch (err) {
      debugPrint(err);
    }
  }
}
