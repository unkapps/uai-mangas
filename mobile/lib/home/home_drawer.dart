import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var authBloc = context.bloc<AuthBloc>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: theme.accentColor,
              ),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  return InkWell(
                    onTap: () async {
                      if (state is Loading) {
                        return;
                      }

                      if (state is Authenticated) {
                        authBloc.add(LoggedOut());
                      } else {
                        authBloc.add(LoginWithFacebookPressed());
                      }
                    },
                    child: state is Loading
                        ? Container(
                            width: 20,
                            height: 20,
                            child: Center(
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.white),
                            ),
                          )
                        : Row(
                            children: <Widget>[
                              Expanded(
                                child: _textBasedOnState(state, theme),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                ),
                              ),
                            ],
                          ),
                  );
                },
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Feed'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações'),
          ),
        ],
      ),
    );
  }

  Text _textBasedOnState(AuthState state, ThemeData theme) {
    String text;
    var style = theme.textTheme.headline6;
    var maxLines = 1;

    if (state is Authenticated) {
      text = state.user.displayName;
    } else if (state is LoginFailed) {
      style = theme.textTheme.bodyText2;
      text = 'Erro no login.\nClique aqui para tentar novamente';
      maxLines = null;
    } else {
      text = 'Entrar';
    }

    return Text(
      text,
      style: style,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
