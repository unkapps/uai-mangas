part of 'firebase_notifications_bloc.dart';

@immutable
abstract class FirebaseNotificationsState {}

class FirebaseNotificationsInitial extends FirebaseNotificationsState {}

class FirebaseNotificationsMessageState extends FirebaseNotificationsState {
  final String title;
  final String message;
  final bool navigate;

  FirebaseNotificationsMessageState(
      {@required this.navigate, @required this.title, @required this.message});

  @override
  String toString() => 'FirebaseNotificationsMessageState';
}

class FirebaseNotificationsMessageNewChapterState
    extends FirebaseNotificationsMessageState {
  final int mangaId;

  FirebaseNotificationsMessageNewChapterState(this.mangaId,
      {@required bool navigate,
      @required String title,
      @required String message})
      : super(navigate: navigate, title: title, message: message);

  @override
  String toString() => 'FirebaseNotificationsMessageNewChapterState';
}
