import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/list/chapter-list.dto.dart';
import 'package:leitor_manga/chapter/list/chapter_item.dart';

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
  static final getIt = GetIt.instance;
  final ChapterService _service = getIt<ChapterService>();

  List<ChapterListDto> _list;
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
          readed: chapterDto.readed,
          date: chapterDto.date,
        );
      },
    );
  }

  void _getMorePages({size = 100, bool desc}) async {
    setState(() {
      _status = Status.LOADING;
    });
    var list = await _service.getList(widget.mangaId, size, _list.length, desc);

    setState(() {
      if (list.isNotEmpty) {
        _list.addAll(list);
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
