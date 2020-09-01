import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_readed_store.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:leitor_manga/app/shared/auth/login_dialog.dart';

class ChapterReaded extends StatelessWidget {
  final chapterListReadedStore = Modular.get<ChapterListReadedStore>();
  final authStore = Modular.get<AuthStore>();

  final int chapterId;

  ChapterReaded({
    Key key,
    @required this.chapterId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (!chapterListReadedStore.chapterStoreById.containsKey(chapterId)) {
          return Container();
        }

        var chapterReadedStore =
            chapterListReadedStore.chapterStoreById[chapterId];

        if (chapterReadedStore.loading) {
          return Container(
            width: 24,
            height: 24,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (chapterReadedStore.loaded) {
          return _buildReaded(context, readed: chapterReadedStore.readed);
        }

        return Container();
      },
    );
  }

  Widget _buildReaded(
    BuildContext context, {
    bool readed = false,
  }) {
    var theme = Theme.of(context);
    var icon = readed ? Icons.check_circle : Icons.check_circle_outline;

    var color = theme.disabledColor;

    if (readed) {
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
            chapterListReadedStore.chapterStoreById[chapterId].toggleReaded();
          } else {
            LoginDialog.createAndShowDialog(context, fromFeature: true);
          }
        },
      ),
    );
  }
}
