import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/chapter_readed/bloc/global_chapter_readed_bloc.dart';
import 'package:leitor_manga/home/home_page.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/splash_screen.dart';
import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';
import 'package:leitor_manga/user/user.service.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _registerServices();
    _authBloc = AuthBloc();
    _authBloc.add(AppStarted());
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
      ],
      child: MaterialApp(
        title: 'Uai Mangás',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            return HomePage();
          },
        ),
      ),
    );
  }

  void _registerServices() {
    final getIt = GetIt.instance;
    getIt.registerSingleton<MangaService>(MangaService());
    getIt.registerSingleton<UserService>(UserService());
    getIt.registerSingleton<ChapterService>(ChapterService());
  }
}
