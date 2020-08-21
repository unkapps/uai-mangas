import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/app/app_controller.dart';
import 'package:leitor_manga/app/app_widget.dart';
import 'package:leitor_manga/app/modules/core/core_module.dart';
import 'package:leitor_manga/app/modules/policies/policies_module.dart';
import 'package:leitor_manga/app/modules/policies/policies_routes.dart';
import 'package:leitor_manga/app/shared/auth/auth.service.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:leitor_manga/app/shared/feed/feed.service.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';
import 'package:leitor_manga/app/shared/notifications/firebase_notifications.service.dart';
import 'package:leitor_manga/app/shared/notifications/notifications_store.dart';
import 'package:leitor_manga/app/shared/version/version_store.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind(
          (i) => AppController(notificationsStore: i.get<NotificationsStore>()),
          lazy: false,
        ),
        Bind((i) => FeedStore()),
        Bind((i) => FeedService()),
        Bind((i) => VersionStore()),
        Bind((i) => AuthStore()),
        Bind((i) => NotificationsStore()),
        Bind((i) => AuthService(firebaseNotifications: i.get()), lazy: false),
        Bind((i) => FirebaseNotifications(i.get()), lazy: false),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, module: CoreModule()),
        Router(PoliciesRoutes.ROOT, module: PoliciesModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
