import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:intl/intl.dart';

import 'package:leitor_manga/chapter/single/chapter_page.dart';
import 'package:leitor_manga/manga/single/manga.page.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';

class LastMangaWithUpdateListView extends StatelessWidget {
  final List<LastMangaWithUpdateDto> mangas;

  const LastMangaWithUpdateListView({Key key, @required this.mangas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: ListView.separated(
        itemCount: mangas.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: 5,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          var manga = mangas[index];

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => MangaPage(mangaId: manga.id)),
              );
            },
            child: Container(
              height: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ExtendedImage.network(
                          manga.coverUrl,
                          width: 85,
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter,
                          cache: true,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            manga.name,
                            style: theme.textTheme.headline6,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 30,
                            width: 60,
                            child: OutlineButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          MangaPage(mangaId: manga.id)),
                                );
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => ChapterPage(
                                            mangaId: manga.id,
                                            chapterId: manga.chapterId,
                                          )),
                                );
                              },
                              child: Text(
                                manga.chapterNumber,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                              borderSide: BorderSide(color: theme.accentColor),
                              shape: StadiumBorder(),
                            ),
                          ),
                          Text(DateFormat('dd/MM/yyyy')
                              .format(manga.date.toLocal())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
