import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:pedantic/pedantic.dart';

class LoginDialog {
  static void createAndShowDialog(BuildContext context,
      {fromFeature = false}) async {
    final authStore = Modular.get<AuthStore>();
    var theme = Theme.of(context);

    switch (await showDialog<LoginType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              Visibility(
                child: Column(children: <Widget>[
                  Center(
                    child: Text('Entre para usar essa funcionalidade'),
                  ),
                  Divider(color: theme.hintColor)
                ]),
                visible: fromFeature,
              ),
              SimpleDialogOption(
                child: SignInButton(
                  Buttons.Facebook,
                  text: 'Entrar com Facebook',
                  onPressed: () {
                    Navigator.pop(context, LoginType.FACEBOOK);
                  },
                ),
              ),
              SimpleDialogOption(
                child: SignInButton(
                  Buttons.Google,
                  text: 'Entrar com Google',
                  onPressed: () {
                    Navigator.pop(context, LoginType.GOOGLE);
                  },
                ),
              ),
              SimpleDialogOption(
                child: SignInButtonBuilder(
                  text: 'Fechar',
                  icon: Icons.close,
                  onPressed: () {
                    Navigator.pop(context, LoginType.NONE);
                  },
                  backgroundColor: Theme.of(context).canvasColor,
                ),
              ),
            ],
          );
        })) {
      case LoginType.FACEBOOK:
        unawaited(authStore.facebookLogin());
        break;
      case LoginType.GOOGLE:
        unawaited(authStore.googleLogin());
        break;
      default:
        break;
    }
  }
}

enum LoginType {
  FACEBOOK,
  GOOGLE,
  NONE,
}
