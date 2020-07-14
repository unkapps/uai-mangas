part of 'firebase_notifications_bloc.dart';

@immutable
abstract class FirebaseNotificationsEvent {
  final bool navigate;

  FirebaseNotificationsEvent({this.navigate = false});
}

abstract class FirebaseNotificationsMessageEvent
    extends FirebaseNotificationsEvent {
  final String title;
  final String message;

  FirebaseNotificationsMessageEvent(
      {@required bool navigate, @required this.title, @required this.message})
      : super(navigate: navigate);
}

class FirebaseNotificationsMessageNewChapterEvent
    extends FirebaseNotificationsMessageEvent {
  final int mangaId;

  FirebaseNotificationsMessageNewChapterEvent(this.mangaId,
      {@required bool navigate,
      @required String title,
      @required String message})
      : super(navigate: navigate, title: title, message: message);

  @override
  String toString() => 'FirebaseNotificationsMessageEvent';
}
