import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/manga/single/manga-favorite/bloc/manga_favorite_bloc.dart';
import 'package:leitor_manga/user/login_dialog.dart';

class MangaFavorite extends StatelessWidget {
  final int mangaId;
  final bool favorite;

  MangaFavorite({Key key, @required this.mangaId, @required this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MangaFavoriteBloc>(
      create: (context) {
        return MangaFavoriteBloc(mangaId)
          ..add(MangaFavoriteLoadedEvent(favorite));
      },
      child: BlocBuilder<MangaFavoriteBloc, MangaFavoriteState>(
        builder: (BuildContext context, MangaFavoriteState state) {
          if (state is MangaFavoriteLoading) {
            return Container(
              width: 24,
              height: 24,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is MangaFavoriteLoaded) {
            return _buildFavorite(context, favorited: state.favorited);
          }

          if (state is ChangeMangaFavoriteError) {
            return _buildFavorite(context,
                favorited: state.oldFavorited);
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildFavorite(
    BuildContext context, {
    bool authenticated = true,
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
          if (authenticated) {
            context
                .bloc<MangaFavoriteBloc>()
                .add(ChangeMangaFavoriteEvent(!favorited));
          } else {
            LoginDialog.createAndShowDialog(context);
          }
        },
      ),
    );
  }
}
