import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_favorite/manga_favorite_store.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:leitor_manga/app/shared/auth/login_dialog.dart';

class MangaFavorite extends StatelessWidget {
  final mangaFavoriteStore = Modular.get<MangaFavoriteStore>();
  final authStore = Modular.get<AuthStore>();

  MangaFavorite({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (mangaFavoriteStore.loading) {
          return Container(
            width: 24,
            height: 24,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        var favorite = mangaFavoriteStore.favorite;
        favorite ??= false;
        return _buildFavorite(context, favorited: favorite);
      },
    );
  }

  Widget _buildFavorite(
    BuildContext context, {
    bool favorited = false,
  }) {
    var theme = Theme.of(context);
    var icon = favorited ? Icons.favorite : Icons.favorite_border;

    var color = theme.disabledColor;

    if (favorited) {
      color = theme.accentColor;
    }

    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          icon,
          size: 24,
          color: color,
        ),
        onPressed: () {
          if (authStore.isAuthenticated) {
            mangaFavoriteStore.toggleFavorite();
          } else {
            LoginDialog.createAndShowDialog(context);
          }
        },
      ),
    );
  }
}
