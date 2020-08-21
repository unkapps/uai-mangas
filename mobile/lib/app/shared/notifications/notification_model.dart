import 'package:flutter/foundation.dart';

@immutable
class NotificationModel {
  final String title;

  final String message;

  final bool navigate;

  final int mangaId;

  NotificationModel({
    @required this.title,
    @required this.message,
    @required this.navigate,
    this.mangaId,
  });
}
