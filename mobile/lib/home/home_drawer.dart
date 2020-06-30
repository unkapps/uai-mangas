import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedantic/pedantic.dart';

import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';
import 'package:leitor_manga/user/login_dialog.dart';
import 'package:leitor_manga/user/user_page.dart';
import 'package:leitor_manga/feed/feed_page.dart';

class HomeDrawer extends StatefulWidget {
  HomeDrawer({Key key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: <Widget>[
          BlocBuilder<AuthBloc, AuthState>(
            builder: (BuildContext context, AuthState state) {
              return Container(
                height: 100,
                child: Material(
                  color: theme.accentColor,
                  child: InkWell(
                    onTap: () async {
                      if (state is Loading) {
                        return;
                      }

                      if (state is Authenticated) {
                        unawaited(Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => UserPage()),
                        ));
                      } else {
                        LoginDialog.createAndShowDialog(context);
                      }
                    },
                    child: DrawerHeader(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
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
                    ),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Feed'),
            onTap: () {
              unawaited(Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => FeedPage()),
              ));
            },
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
