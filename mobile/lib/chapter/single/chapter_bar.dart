import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/chapter/single/chapter_page.dart';
import 'package:leitor_manga/chapter/single/chapter_page_dialog.dart';
import 'package:leitor_manga/chapter/single/chapter_vertical_list_view.dart';
import 'package:pedantic/pedantic.dart';

class ChapterBar extends StatelessWidget {
  final ChapterDto _chapter;
  final ChapterController _chapterController;

  const ChapterBar(this._chapter, this._chapterController, {Key key})
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
                    color: Colors.white,
                  ),
                  tooltip: 'Capítulo anterior',
                  onPressed: () {
                    _goToChapter(context, _chapter.previousChapterId);
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
                        color: Colors.white,
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
                    style: TextStyle(
                      color: Colors.white,
                    ),
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
                        color: Colors.white,
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
                    color: Colors.white,
                  ),
                  tooltip: 'Próximo capítulo',
                  onPressed: () {
                    _goToChapter(context, _chapter.nextChapterId);
                  },
                )
              : Container(
                  width: 48,
                ),
        ],
      ),
    );
  }

  void _goToChapter(BuildContext context, int chapterId) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ChapterPage(chapterId)),
      (Route<dynamic> route) => false,
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
