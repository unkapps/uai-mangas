import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leitor_manga/user/user.service.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:pedantic/pedantic.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserService userService;

  AuthBloc({@required this.userService});

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is LoginWithFacebookPressed) {
      yield* _mapLoginWithFacebookPressedToState();
    } else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await userService.isSignedIn();
      if (isSignedIn) {
        final user = await userService.getUser();
        yield Authenticated(user);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthState> _mapLoggedInToState() async* {
    yield Authenticated(await userService.getUser());
  }

  Stream<AuthState> _mapLoggedOutToState() async* {
    yield Loading();
    await unawaited(userService.signOut());
    yield Unauthenticated();
  }

  Stream<AuthState> _mapLoginWithFacebookPressedToState() async* {
    try {
      yield Loading();
      if ((await userService.signInWithFacebook()) != null) {
        yield* _mapLoggedInToState();
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield LoginFailed();
    }
  }

  Stream<AuthState> _mapLoginWithGooglePressedToState() async* {
    try {
      yield Loading();
      if ((await userService.signInWithGoogle()) != null) {
        yield* _mapLoggedInToState();
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield LoginFailed();
    }
  }
}
