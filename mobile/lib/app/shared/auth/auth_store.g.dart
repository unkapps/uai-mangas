// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_AuthStoreBase.isLoading'))
          .value;
  Computed<bool> _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated =>
      (_$isAuthenticatedComputed ??= Computed<bool>(() => super.isAuthenticated,
              name: '_AuthStoreBase.isAuthenticated'))
          .value;
  Computed<bool> _$authenticationFailedComputed;

  @override
  bool get authenticationFailed => (_$authenticationFailedComputed ??=
          Computed<bool>(() => super.authenticationFailed,
              name: '_AuthStoreBase.authenticationFailed'))
      .value;
  Computed<String> _$providerIdComputed;

  @override
  String get providerId =>
      (_$providerIdComputed ??= Computed<String>(() => super.providerId,
              name: '_AuthStoreBase.providerId'))
          .value;

  final _$statusAtom = Atom(name: '_AuthStoreBase.status');

  @override
  AuthStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$userAtom = Atom(name: '_AuthStoreBase.user');

  @override
  FirebaseUser get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(FirebaseUser value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$errorAtom = Atom(name: '_AuthStoreBase.error');

  @override
  Object get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Object value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$loadUserIfIsSignedInAsyncAction =
      AsyncAction('_AuthStoreBase.loadUserIfIsSignedIn');

  @override
  Future<void> loadUserIfIsSignedIn() {
    return _$loadUserIfIsSignedInAsyncAction
        .run(() => super.loadUserIfIsSignedIn());
  }

  final _$facebookLoginAsyncAction =
      AsyncAction('_AuthStoreBase.facebookLogin');

  @override
  Future<void> facebookLogin() {
    return _$facebookLoginAsyncAction.run(() => super.facebookLogin());
  }

  final _$googleLoginAsyncAction = AsyncAction('_AuthStoreBase.googleLogin');

  @override
  Future<void> googleLogin() {
    return _$googleLoginAsyncAction.run(() => super.googleLogin());
  }

  final _$logoutAsyncAction = AsyncAction('_AuthStoreBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
status: ${status},
user: ${user},
error: ${error},
isLoading: ${isLoading},
isAuthenticated: ${isAuthenticated},
authenticationFailed: ${authenticationFailed},
providerId: ${providerId}
    ''';
  }
}
