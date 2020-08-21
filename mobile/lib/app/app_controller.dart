import 'package:flutter/foundation.dart';
import 'package:leitor_manga/app/shared/notifications/foreground_notification.dart';
import 'package:leitor_manga/app/shared/notifications/notifications_store.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/material_builder.dart'
    as material_builder;

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase extends Disposable with Store {
  final NotificationsStore notificationsStore;
  ReactionDisposer notificationsDisposer;

  _AppBase({
    @required this.notificationsStore,
  }) {
    notificationsDisposer = autorun((_) {
      if (notificationsStore.notification.mangaId != null) {
        ForegroundNotification.showNewChapter(
            notificationsStore.notification, material_builder.context);
      }
    });
  }

  @override
  void dispose() {
    if (notificationsDisposer != null) {
      notificationsDisposer();
    }
  }
}
