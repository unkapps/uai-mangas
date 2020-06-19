import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.bloc<AuthBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (BuildContext context, AuthState state) {
            if (state is Authenticated) {
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
                            '${state.user.displayName}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        ListTile(
                          title: Text(
                            'Origem',
                          ),
                          subtitle: Text(
                            '${state.user.providerData[state.user.providerData.length > 1 ? 1 : 0].providerId}',
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
                      authBloc.add(LoggedOut());
                    },
                  ),
                ],
              );
            }

            if (state is Loading) {
              return Container(
                width: 40,
                height: 40,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            SchedulerBinding.instance.addPostFrameCallback((_) async {
              Navigator.pop(context);
            });

            return Container();
          },
        ),
      ),
    );
  }
}
