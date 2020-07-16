import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/chapter_readed/bloc/global_chapter_readed_bloc.dart';
import 'package:leitor_manga/firebase/notifications/bloc/firebase_notifications_bloc.dart';
import 'package:leitor_manga/firebase/notifications/firebase_notifications.service.dart';
import 'package:leitor_manga/firebase/notifications/foreground_notification.dart';
import 'package:leitor_manga/home/home_page.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/splash_screen.dart';
import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';
import 'package:leitor_manga/feed/bloc/feed_bloc.dart';
import 'package:leitor_manga/user/user.service.dart';
import 'package:leitor_manga/version/bloc/version_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthBloc _authBloc;
  FeedBloc _feedBloc;
  VersionBloc _versionBloc;
  FirebaseNotificationsBloc _firebaseNotificationsBloc;

  @override
  void initState() {
    super.initState();

    _firebaseNotificationsBloc = FirebaseNotificationsBloc();
    _registerServices();
    _authBloc = AuthBloc();
    _feedBloc = FeedBloc();
    _versionBloc = VersionBloc();

    _authBloc.add(AppStarted());
    _versionBloc.add(LoadVersionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => _authBloc,
        ),
        BlocProvider<GlobalChapterReadedBloc>(
          create: (BuildContext context) => GlobalChapterReadedBloc(),
        ),
        BlocProvider<FeedBloc>(
          create: (BuildContext context) => _feedBloc,
        ),
        BlocProvider<VersionBloc>(
          create: (BuildContext context) => _versionBloc,
        ),
        BlocProvider<FirebaseNotificationsBloc>(
          create: (BuildContext context) => _firebaseNotificationsBloc,
        ),
      ],
      child: MaterialApp(
        title: 'Uai Mangás',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MultiBlocListener(
          listeners: [
            BlocListener<FirebaseNotificationsBloc, FirebaseNotificationsState>(
              listener: (context, state) {
                if (state is FirebaseNotificationsMessageNewChapterState) {
                  ForegroundNotification.showNewChapter(state, context);
                }
              },
            ),
            BlocListener<GlobalChapterReadedBloc, GlobalChapterReadedState>(
              listener: (context, state) {
                if (state is GlobalChapterReadedFromLocal) {
                  context.bloc<FeedBloc>().add(LoadFeedEvent());
                }
              },
            ),
          ],
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                _feedBloc.add(LoadFeedEvent());
              } else if (state is Unauthenticated) {
                _feedBloc.add(UnauthenticatedFeedEvent());
              }
            },
            builder: (BuildContext context, AuthState state) {
              if (state is Uninitialized) {
                return SplashScreen();
              }
              return HomePage();
            },
          ),
        ),
      ),
    );
  }

  void _registerServices() {
    final getIt = GetIt.instance;

    var fireBaseNotifications =
        FirebaseNotifications(_firebaseNotificationsBloc);

    fireBaseNotifications.init();

    getIt.registerSingleton<FirebaseNotifications>(fireBaseNotifications);

    getIt.registerSingleton<MangaService>(MangaService());
    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<ChapterService>(ChapterService());
  }
}
