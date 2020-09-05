import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/feed_count.dart';
import 'package:leitor_manga/app/modules/policies/policies_routes.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:leitor_manga/app/shared/auth/login_dialog.dart';
import 'package:leitor_manga/app/shared/facebook_page_button.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';
import 'package:leitor_manga/app/shared/googleplay_button.dart';
import 'package:leitor_manga/app/shared/version/version.dart';
import 'package:pedantic/pedantic.dart';

class HomeDrawer extends StatefulWidget {
  final AuthStore authStore;
  final FeedStore feedStore;

  HomeDrawer({
    @required this.authStore,
    @required this.feedStore,
    Key key,
  }) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: <Widget>[
              Observer(
                builder: (_) {
                  return Container(
                    height: 100,
                    child: Material(
                      color: theme.accentColor,
                      child: InkWell(
                        onTap: () async {
                          if (widget.authStore.isLoading) {
                            return;
                          }

                          if (widget.authStore.isAuthenticated) {
                            unawaited(Modular.link.pushNamed(Routes.USER));
                          } else {
                            LoginDialog.createAndShowDialog(context);
                          }
                        },
                        child: DrawerHeader(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: widget.authStore.isLoading
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
                                      child: _textBasedOnState(theme),
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
                leading: Container(
                  width: 24,
                  height: 24,
                  child: FeedCount(
                    feedStore: widget.feedStore,
                    top: 0,
                    left: 0,
                    fit: StackFit.expand,
                    child: Icon(Icons.notifications),
                  ),
                ),
                title: Text('Feed'),
                onTap: () {
                  if (widget.authStore.isAuthenticated) {
                    widget.feedStore.load();
                    unawaited(Modular.link.pushNamed(Routes.FEED));
                  } else {
                    LoginDialog.createAndShowDialog(context, fromFeature: true);
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.warning),
                title: Text('DMCA'),
                onTap: () {
                  unawaited(Modular.link.pushNamed(PoliciesRoutes.DMCA));
                },
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.only(top: 15, right: 5, left: 15, bottom: 5),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GooglePlayButton(),
                    FacebookPageButton(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, right: 15, left: 15, bottom: 15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Version(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _textBasedOnState(ThemeData theme) {
    String text;
    var style = theme.textTheme.headline6;
    var maxLines = 1;

    if (widget.authStore.isAuthenticated) {
      text = widget.authStore.user.displayName;
    } else if (widget.authStore.authenticationFailed) {
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
