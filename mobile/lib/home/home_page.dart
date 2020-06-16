import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dart';
import 'package:leitor_manga/manga/list/manga_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageStorageKey _lastMangaWithUpdateKey;
  PageStorageKey _allMangaWithUpdateKey;

  @override
  void initState() {
    _lastMangaWithUpdateKey = PageStorageKey('l');
    _allMangaWithUpdateKey = PageStorageKey('a');

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Uai Mangás'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Últimas atualizações'),
              Tab(text: 'Todos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: LastMangaWithUpdate(key: _lastMangaWithUpdateKey),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: MangaList(key: _allMangaWithUpdateKey, showCount: true,),
            ),
          ],
        ),
      ),
    );
  }
}
