import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/notifications/notification_model.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';

class ForegroundNotification {
  static void showNewChapter(
      NotificationModel notification, BuildContext context) {
    if (notification.navigate) {
      _openMangaPage(context, notification.mangaId);
    } else {
      final theme = Theme.of(context);
      Flushbar(
        titleText: Text(
          notification.title,
          style: theme.textTheme.headline6,
        ),
        messageText: Text(
          notification.message,
          style: theme.textTheme.subtitle2,
        ),
        duration: Duration(seconds: 15),
        isDismissible: true,
        flushbarPosition: FlushbarPosition.BOTTOM,
        margin: EdgeInsets.all(8),
        borderRadius: 8,
        leftBarIndicatorColor: theme.accentColor,
        backgroundColor: theme.dialogBackgroundColor,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
        icon: Icon(
          Icons.info_outline,
          size: 28.0,
          color: theme.accentColor,
        ),
        onTap: (Flushbar flushbar) {
          _openMangaPage(context, notification.mangaId);
        },
      )..show(context);
    }
  }

  static void _openMangaPage(BuildContext context, int mangaId) {
    Modular.link.pushNamed(Routes.MANGA_SINGLE.replaceAll(':mangaId', mangaId.toString()));
  }
}
