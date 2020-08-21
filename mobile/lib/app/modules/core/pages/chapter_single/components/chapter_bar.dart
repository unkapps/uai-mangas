import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/chapter_navigation_dialog.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';

import 'package:pedantic/pedantic.dart';

typedef ChapterChangeListener = void Function(bool movedForward);

class ChapterBar extends StatelessWidget {
  final chapterSingleController = Modular.get<ChapterSingleController>();

  final ChapterSingleModel _chapter;
  final ChapterChangeListener onChapterChange;

  ChapterBar(this._chapter, {Key key, this.onChapterChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _chapter.previousChapterId != null
              ? IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                  ),
                  tooltip: 'Capítulo anterior',
                  onPressed: () {
                    if (onChapterChange != null) {
                      onChapterChange(false);
                    }
                    _goToChapter(context,
                        mangaId: _chapter.mangaId,
                        chapterId: _chapter.previousChapterId);
                  },
                )
              : Container(
                  width: 48,
                ),
          Row(
            children: <Widget>[
              chapterSingleController.currentPage > 0
                  ? IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                      ),
                      tooltip: 'Página anterior',
                      onPressed: () {
                        chapterSingleController.previousPage();
                      },
                    )
                  : Container(
                      width: 48,
                    ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 80.0,
                ),
                child: InkWell(
                  child: Observer(builder: (_) {
                    return Text(
                      '${chapterSingleController.currentPage + 1}/${_chapter.pages.length}',
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    );
                  }),
                  onTap: () {
                    _chapterDialog(context);
                  },
                ),
              ),
              chapterSingleController.currentPage + 1 < _chapter.pages.length
                  ? IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                      tooltip: 'Próxima página',
                      onPressed: () {
                        chapterSingleController.nextPage();
                      },
                    )
                  : Container(
                      width: 48,
                    ),
            ],
          ),
          _chapter.nextChapterId != null
              ? IconButton(
                  icon: Icon(
                    Icons.skip_next,
                  ),
                  tooltip: 'Próximo capítulo',
                  onPressed: () {
                    if (onChapterChange != null) {
                      onChapterChange(true);
                    }
                    _goToChapter(context,
                        mangaId: _chapter.mangaId,
                        chapterId: _chapter.nextChapterId);
                  },
                )
              : Container(
                  width: 48,
                ),
        ],
      ),
    );
  }

  void _goToChapter(BuildContext context,
      {@required int mangaId, @required int chapterId}) {
    Modular.link.pushNamed(Routes.CHAPTER_SINGLE
        .replaceAll(':mangaId', mangaId.toString())
        .replaceAll(':chapterId', chapterId.toString()));
  }

  Future<void> _chapterDialog(BuildContext context) async {
    var chosenPage = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return ChapterNavigationDialog(_chapter);
        });

    if (chosenPage != null) {
      chosenPage = chosenPage - 1;
      unawaited(chapterSingleController.goToPage(chosenPage, true));
    }
  }
}
