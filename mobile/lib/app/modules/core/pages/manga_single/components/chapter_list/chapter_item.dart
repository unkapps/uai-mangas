import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_readed.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';

class ChapterItem extends StatelessWidget {
  final int chapterId;
  final String number;
  final DateTime date;
  final int mangaId;

  const ChapterItem({
    Key key,
    @required this.chapterId,
    @required this.number,
    @required this.date,
    @required this.mangaId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
        child: ListTile(
          title: Row(
            children: <Widget>[
              ChapterReaded(
                chapterId: chapterId,
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
            Modular.link.pushNamed(Routes.CHAPTER_SINGLE
                .replaceAll(':mangaId', mangaId.toString())
                .replaceAll(':chapterId', chapterId.toString()));
          },
        ),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: theme.cardColor))));
  }
}
