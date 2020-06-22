import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:leitor_manga/chapter/single/chapter_page.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/single/manga.page.dart';
import 'package:extended_future_builder/extended_future_builder.dart';

class LastMangaWithUpdate extends StatefulWidget {
  LastMangaWithUpdate({Key key}) : super(key: key);

  @override
  _LastMangaWithUpdateState createState() => _LastMangaWithUpdateState();
}

class _LastMangaWithUpdateState extends State<LastMangaWithUpdate> {
  static final getIt = GetIt.instance;
  final MangaService mangaService = getIt<MangaService>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ExtendedFutureBuilder<List<LastMangaWithUpdateDto>>(
      futureResponseBuilder: () => mangaService.getLastMangaWithUpdate(),
      errorBuilder: (BuildContext context, error) {
        return Center(
          child: Text('Erro! Clique para tentar novamente.'),
        );
      },
      successBuilder:
          (BuildContext context, List<LastMangaWithUpdateDto> mangas) {
        return ListView.separated(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ExtendedImage.network(
                      manga.coverUrl,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topCenter,
                      cache: true,
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
                                        builder: (context) =>
                                            ChapterPage(manga.chapterId)),
                                  );
                                },
                                child: Text(
                                  manga.chapterNumber,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                  ),
                                ),
                                borderSide:
                                    BorderSide(color: theme.accentColor),
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
        );
      },
    );
  }
}
