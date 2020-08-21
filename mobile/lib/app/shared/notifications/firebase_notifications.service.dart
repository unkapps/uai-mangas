import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/app/shared/notifications/notification_model.dart';
import 'package:leitor_manga/app/shared/notifications/notifications_store.dart';

class FirebaseNotifications {
  final FirebaseMessaging firebaseMessaging;
  final NotificationsStore notificationsStore;

  FirebaseNotifications(this.notificationsStore)
      : firebaseMessaging = FirebaseMessaging() {
    init();
  }

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
    _dealWithMessage(message, true);
  }

  Future<dynamic> _onMessage(Map<String, dynamic> message) async {
    _dealWithMessage(message, false);
  }

  void _dealWithMessage(Map<String, dynamic> message, bool navigate) {
    if (message.containsKey('data')) {
      var data = message['data'] as Map<dynamic, dynamic>;
      var notification = message['notification'] as Map<dynamic, dynamic>;
      if (data.containsKey('manga_id')) {
        var mangaId = int.parse(data['manga_id']);
        var title = notification['title'];
        var message = notification['body'];

        notificationsStore.newMessage(
          NotificationModel(
            title: title,
            message: message,
            navigate: navigate,
            mangaId: mangaId,
          ),
        );
      }
    }

    return null;
  }
}
