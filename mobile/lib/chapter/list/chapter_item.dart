import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:leitor_manga/chapter/chapter_readed/chapter_readed.dart';
import 'package:leitor_manga/chapter/single/chapter_page.dart';

class ChapterItem extends StatelessWidget {
  final int chapterId;
  final bool readed;
  final String number;
  final DateTime date;
  final int mangaId;

  const ChapterItem({
    Key key,
    @required this.chapterId,
    @required this.readed,
    @required this.number,
    @required this.date,
    @required this.mangaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          ChapterReaded(
            chapterId: chapterId,
            initialReaded: readed,
          ),
          const Divider(
            indent: 10,
            endIndent: 0,
          ),
          Text('#$number'),
        ],
      ),
      subtitle: Container(
        padding: EdgeInsets.only(left: 30),
        child: Text(
            '${date != null ? DateFormat('dd/MM/yyyy').format(date.toLocal()) : ''}'),
      ),
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) =>
                  ChapterPage(mangaId: mangaId, chapterId: chapterId)),
        );
      },
    );
  }
}
