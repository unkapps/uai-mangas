import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/home/home_page.dart';
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
  final UserService userService = UserService();
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(userService: userService);
    _authBloc.add(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => _authBloc,
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
}
