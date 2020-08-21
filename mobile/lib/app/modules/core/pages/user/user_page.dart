import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final authStore = Modular.get<AuthStore>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Observer(
          builder: (_) {
            if (authStore.isAuthenticated) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                'Conectado!',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                      color: Colors.green,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Nome',
                          ),
                          subtitle: Text(
                            '${authStore.user.displayName}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Origem',
                          ),
                          subtitle: Text(
                            '${authStore.providerId}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  FlatButton(
                    child: Text('Sair'),
                    onPressed: () {
                      authStore.logout();
                    },
                  ),
                ],
              );
            }

            if (authStore.isLoading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }

            SchedulerBinding.instance.scheduleFrameCallback((_) async {
              Navigator.pop(context);
            });

            return Container();
          },
        ),
      ),
    );
  }
}
