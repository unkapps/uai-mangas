import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/chapter/single/chapter_page.dart';
import 'package:leitor_manga/chapter/single/chapter_page_dialog.dart';
import 'package:leitor_manga/chapter/single/chapter_vertical_list_view.dart';
import 'package:pedantic/pedantic.dart';

typedef ChapterChangeListener = void Function(bool movedForward);

class ChapterBar extends StatelessWidget {
  final ChapterDto _chapter;
  final ChapterController _chapterController;
  final ChapterChangeListener onChapterChange;

  const ChapterBar(this._chapter, this._chapterController,
      {Key key, this.onChapterChange})
      : super(key: key);

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
              _chapterController.currentPage > 0
                  ? IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                      ),
                      tooltip: 'Página anterior',
                      onPressed: () {
                        _chapterController.previousPage();
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
                  child: Text(
                    '${_chapterController.currentPage + 1}/${_chapter.pages.length}',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                  onTap: () {
                    _chapterDialog(context);
                  },
                ),
              ),
              _chapterController.currentPage + 1 < _chapter.pages.length
                  ? IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                      tooltip: 'Próxima página',
                      onPressed: () {
                        _chapterController.nextPage();
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
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) =>
            ChapterPage(mangaId: mangaId, chapterId: chapterId),
      ),
    );
  }

  Future<void> _chapterDialog(BuildContext context) async {
    var chosenPage = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return ChapterPageDialog(_chapter);
        });

    if (chosenPage != null) {
      chosenPage = chosenPage - 1;
      unawaited(_chapterController.goToPage(chosenPage, true));
    }
  }
}
