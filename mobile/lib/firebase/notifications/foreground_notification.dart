import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/firebase/notifications/bloc/firebase_notifications_bloc.dart';
import 'package:leitor_manga/manga/single/manga.page.dart';

class ForegroundNotification {
  static void showNewChapter(
      FirebaseNotificationsMessageNewChapterState state, BuildContext context) {
    if (state.navigate) {
      _openMangaPage(context, state.mangaId);
    } else {
      final theme = Theme.of(context);
      Flushbar(
        titleText: Text(
          state.title,
          style: theme.textTheme.headline6,
        ),
        messageText: Text(
          state.message,
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
          _openMangaPage(context, state.mangaId);
        },
      )..show(context);
    }
  }

  static void _openMangaPage(BuildContext context, int mangaId) {
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => MangaPage(mangaId: mangaId)),
    );
  }
}
