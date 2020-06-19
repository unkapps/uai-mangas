import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';

class LoginDialog {
  static void createAndShowDialog(BuildContext context) async {
    switch (await showDialog<LoginType>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
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
        context.bloc<AuthBloc>().add(LoginWithFacebookPressed());
        break;
      default:
        break;
    }
  }
}

enum LoginType {
  FACEBOOK,
  NONE,
}
