import 'package:extended_future_builder/extended_future_builder.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/manga/list/manga_list.dto.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/single/manga.page.dart';

class MangaList extends StatefulWidget {
  MangaList({Key key}) : super(key: key);

  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {
  final mangaService = MangaService();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExtendedFutureBuilder<List<MangaListDto>>(
      futureResponseBuilder: () => mangaService.getAllManga(),
      errorBuilder: (BuildContext context, error) {
        return Center(
          child: Text('Erro! Clique para tentar novamente.'),
        );
      },
      successBuilder: (BuildContext context, List<MangaListDto> mangas) {
        return GridView.builder(
          itemCount: mangas.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (BuildContext context, int index) {
            var manga = mangas[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MangaPage(mangaId: manga.id)),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.dividerColor,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ExtendedImage.network(
                        manga.coverUrl,
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.topCenter,
                        cache: true,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        manga.name,
                        style: theme.textTheme.headline6,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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
