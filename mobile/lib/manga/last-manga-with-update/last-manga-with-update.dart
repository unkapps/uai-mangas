import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last_manga_with_update_listview.dart';

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
    return ExtendedFutureBuilder<List<LastMangaWithUpdateDto>>(
      futureResponseBuilder: () => mangaService.getLastMangaWithUpdate(),
      errorBuilder: (BuildContext context, error) {
        return Center(
          child: Text('Erro! Clique para tentar novamente.'),
        );
      },
      successBuilder:
          (BuildContext context, List<LastMangaWithUpdateDto> mangas) {
        return LastMangaWithUpdateListView(mangas: mangas);
      },
    );
  }
}
