import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/last_manga_with_update/last_manga_with_update_store.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_listview/manga_listview.dart';

class LastMangaWithUpdate extends StatefulWidget {
  LastMangaWithUpdate({Key key}) : super(key: key);

  @override
  _LastMangaWithUpdateState createState() => _LastMangaWithUpdateState();
}

class _LastMangaWithUpdateState extends State<LastMangaWithUpdate> {
  final lastMangaWithUpdateStore = Modular.get<LastMangaWithUpdateStore>();

  @override
  void initState() {
    super.initState();
    lastMangaWithUpdateStore.loadMangas();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (lastMangaWithUpdateStore.hasError) {
          return InkWell(
            child: Center(
              child: Text('Erro! Clique para tentar novamente.'),
            ),
            onTap: () {
              lastMangaWithUpdateStore.loadMangas();
            },
          );
        }

        if (lastMangaWithUpdateStore.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return MangaListView(mangas: lastMangaWithUpdateStore.mangas);
      },
    );
  }
}
