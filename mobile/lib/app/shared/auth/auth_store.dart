import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/auth/auth.service.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final AuthService _authService = Modular.get();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  FirebaseUser user;

  @observable
  Object error;

  _AuthStoreBase() {
    loadUserIfIsSignedIn();
  }

  @computed
  bool get isLoading {
    return status == AuthStatus.loading;
  }

  @computed
  bool get isAuthenticated {
    return !isLoading && user != null;
  }

  @computed
  bool get authenticationFailed {
    return error != null;
  }

  @computed
  String get providerId {
    return user != null ? user.providerData[user.providerData.length > 1 ? 1 : 0].providerId : null;
  }

  @action
  Future<void> loadUserIfIsSignedIn() async {
    status = AuthStatus.loading;
    error = null;

    final isSignedIn = await _authService.isSignedIn();
    if (isSignedIn) {
      user = await _authService.getUser();
      status = AuthStatus.authenticated;
    } else {
      status = AuthStatus.unauthenticated;
    }
  }

  @action
  Future<void> facebookLogin() async {
    _startLogin();

    try {
      user = await _authService.signInWithFacebook();
    } catch (error) {
      this.error = error;
    }

    _dealWithLogin();
  }

  @action
  Future<void> googleLogin() async {
    _startLogin();

    try {
      user = await _authService.signInWithGoogle();
    } catch (error) {
      this.error = error;
    }

    _dealWithLogin();
  }

  @action
  Future<void> logout() async {
    _startLogout();

    try {
      await _authService.signOut();
      user = null;
    } catch (error) {
      this.error = error;
    }

    _dealWithLogout();
  }

  void _startLogin() {
    status = AuthStatus.loading;
    error = null;
  }

  void _startLogout() {
    status = AuthStatus.loading;
    error = null;
  }

  void _dealWithLogin() {
    if (user != null) {
      status = AuthStatus.authenticated;
    } else {
      status = AuthStatus.unauthenticated;
    }
  }

  void _dealWithLogout() {
    if (user == null) {
      status = AuthStatus.unauthenticated;
    }

    if (error != null) {
      status = AuthStatus.authenticated;
    }
  }
}

enum AuthStatus { loading, authenticated, unauthenticated }
