import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'firebase_notifications_event.dart';
part 'firebase_notifications_state.dart';

class FirebaseNotificationsBloc
    extends Bloc<FirebaseNotificationsEvent, FirebaseNotificationsState> {
  FirebaseNotificationsBloc() : super(FirebaseNotificationsInitial());

  @override
  Stream<FirebaseNotificationsState> mapEventToState(
    FirebaseNotificationsEvent event,
  ) async* {
    if (event is FirebaseNotificationsMessageNewChapterEvent) {
      yield FirebaseNotificationsMessageNewChapterState(event.mangaId,
          navigate: event.navigate, title: event.title, message: event.message);
    }
  }
}
