part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Uninitialized extends AuthState {
  @override
  String toString() => 'Uninitialized';

  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final FirebaseUser user;

  Authenticated(this.user);

  @override
  String toString() => 'Authenticated { displayName: ${user.displayName} }';

  @override
  List<Object> get props => [user.uid];
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';

  @override
  List<Object> get props => [];
}

class LoginFailed extends AuthState {
  @override
  String toString() => 'LoginFailed';

  @override
  List<Object> get props => [];
}

class Loading extends AuthState {
  @override
  String toString() => 'Loading';

  @override
  List<Object> get props => [];
}
