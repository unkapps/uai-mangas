import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:leitor_manga/firebase/notifications/bloc/firebase_notifications_bloc.dart';

class FirebaseNotifications {
  final FirebaseMessaging firebaseMessaging;
  final FirebaseNotificationsBloc bloc;

  FirebaseNotifications(this.bloc) : firebaseMessaging = FirebaseMessaging();

  void init() {
    configureListeners();
  }

  void configureListeners() async {
    debugPrint('token: ${await firebaseMessaging.getToken()}');

    firebaseMessaging.configure(
      onMessage: _onMessage,
      onResume: _onLaunch,
      onLaunch: _onLaunch,
    );
  }

  Future<dynamic> _onLaunch(Map<String, dynamic> message) async {
    var event = _getEventFromMessage(message, true);

    if (event != null) {
      bloc.add(event);
    }
  }
  
  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    var event = _getEventFromMessage(message, false);

    if (event != null) {
      bloc.add(event);
    }
  }

  static FirebaseNotificationsMessageEvent _getEventFromMessage(
      Map<String, dynamic> message, bool navigate) {
    if (message.containsKey('data')) {
      var data = message['data'] as Map<dynamic, dynamic>;
      var notification = message['notification'] as Map<dynamic, dynamic>;
      if (data.containsKey('manga_id')) {
        var mangaId = int.parse(data['manga_id']);
        var title = notification['title'];
        var message = notification['body'];

        return FirebaseNotificationsMessageNewChapterEvent(mangaId, navigate: navigate,
            title: title, message: message);
      }
    }

    return null;
  }
}
