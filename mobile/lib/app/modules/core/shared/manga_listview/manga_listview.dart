import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_listview/manga_listview_model.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';

class MangaListView extends StatelessWidget {
  final List<MangaListViewModel> mangas;

  const MangaListView({Key key, @required this.mangas}) : super(key: key);

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
              Modular.link.pushNamed(Routes.MANGA_SINGLE
                  .replaceAll(':mangaId', manga.id.toString()));
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
                            width: manga.chapterNumber != null ? 80 : 120,
                            child: OutlineButton(
                              onPressed: () {
                                Modular.link.pushNamed(Routes.MANGA_SINGLE
                                    .replaceAll(
                                        ':mangaId', manga.id.toString()));

                                if (manga.chapterId != null) {
                                  Modular.link.pushNamed(Routes.CHAPTER_SINGLE
                                      .replaceAll(
                                          ':mangaId', manga.id.toString())
                                      .replaceAll(':chapterId',
                                          manga.chapterId.toString()));
                                }
                              },
                              child: Text(
                                manga.chapterNumber ?? 'Começar a ler',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                              ),
                              borderSide: BorderSide(color: theme.accentColor),
                              shape: StadiumBorder(),
                            ),
                          ),
                          manga.date != null
                              ? Text(DateFormat('dd/MM/yyyy')
                                  .format(manga.date.toLocal()))
                              : Container(),
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
