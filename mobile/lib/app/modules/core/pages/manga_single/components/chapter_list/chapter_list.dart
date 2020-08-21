import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_item.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_model.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_readed_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_readed_store.dart';
import 'package:leitor_manga/app/modules/core/shared/chapter.service.dart';

class ChapterList extends StatefulWidget {
  final int mangaId;
  final int qtyChapters;
  final int initialFetch;
  final bool allowFetchMore;
  final bool desc;

  ChapterList({
    Key key,
    @required this.mangaId,
    @required this.qtyChapters,
    this.initialFetch = 20,
    this.allowFetchMore = true,
    this.desc = true,
  }) : super(key: key);

  @override
  ChapterListState createState() => ChapterListState();
}

enum Status { LOADING, ERROR, DONE }

class ChapterListState extends State<ChapterList> {
  final chapterService = Modular.get<ChapterService>();
  final chapterListReadedStore = Modular.get<ChapterListReadedStore>();

  List<ChapterListModel> _list;
  Status _status;
  bool get _endGettingChapters => widget.qtyChapters == _list.length;

  @override
  void initState() {
    _list = [];

    _getMorePages(size: widget.initialFetch, desc: widget.desc);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.allowFetchMore ? _list.length + 1 : _list.length,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == _list.length) {
          if (_status == Status.LOADING) {
            return Container(
              child: Center(
                child: Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.all(15),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            );
          }

          return Container(
            height: _endGettingChapters ? 0 : 55,
          );
        }

        var chapterDto = _list[index];

        return ChapterItem(
          chapterId: chapterDto.id,
          mangaId: widget.mangaId,
          number: chapterDto.number,
          date: chapterDto.date,
        );
      },
    );
  }

  void _getMorePages({size = 100, bool desc}) async {
    setState(() {
      _status = Status.LOADING;
    });
    var list =
        await chapterService.getList(widget.mangaId, size, _list.length, desc);

    setState(() {
      if (list.isNotEmpty) {
        _list.addAll(list);
      }

      for (var chapter in list) {
        if (!chapterListReadedStore.chapterStoreById.containsKey(chapter.id)) {
          chapterListReadedStore.chapterStoreById[chapter.id] =
              ChapterReadedStore(chapter.id, chapter.readed);
        }
      }

      _status = Status.DONE;
    });
  }

  bool onNotification(ScrollNotification scrollInfo, maxScrollExtent) {
    if (widget.allowFetchMore) {
      if (scrollInfo is ScrollEndNotification &&
          !_endGettingChapters &&
          _status != Status.LOADING) {
        if (scrollInfo.metrics.pixels == maxScrollExtent) {
          _getMorePages(desc: widget.desc);
        }
      }
    }

    return false;
  }
}
