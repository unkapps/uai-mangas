import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/list/chapter-list.dto.dart';
import 'package:leitor_manga/chapter/single/chapter_page.dart';

class ChapterList extends StatefulWidget {
  final int qtyChapters;
  ChapterList({Key key, @required this.qtyChapters}) : super(key: key);

  @override
  ChapterListState createState() => ChapterListState();
}

enum Status { LOADING, ERROR, DONE }

class ChapterListState extends State<ChapterList> {
  final ChapterService _service = ChapterService();

  List<ChapterListDto> _list;
  Status _status;
  bool get _endGettingChapters => this.widget.qtyChapters == _list.length;

  @override
  void initState() {
    _list = [];
    _getMorePages(size: 20);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _list.length + 1,
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

        return ListTile(
          title: Text('#${chapterDto.number}'),
          subtitle: Text(
              '${chapterDto.date != null ? DateFormat('dd/MM/yyyy').format(chapterDto.date.toLocal()) : ''}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChapterPage(chapterDto.id)),
            );
          },
        );
      },
    );
  }

  _getMorePages({size = 100}) async {
    setState(() {
      _status = Status.LOADING;
    });
    List<ChapterListDto> list = await _service.getList(577, size, _list.length);

    setState(() {
      if (list.isNotEmpty) {
        _list.addAll(list);
      }

      _status = Status.DONE;
    });
  }

  bool onNotification(ScrollNotification scrollInfo, maxScrollExtent) {
    if (scrollInfo is ScrollEndNotification &&
        !_endGettingChapters &&
        _status != Status.LOADING) {
      if (scrollInfo.metrics.pixels == maxScrollExtent) {
        _getMorePages();
      }
    }

    return false;
  }
}