import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/changelog/changelog_service.dart';
import 'package:leitor_manga/home/home_drawer.dart';
import 'package:leitor_manga/home/drawer_count.dart';

import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dart';
import 'package:leitor_manga/manga/list/manga_list.dart';
import 'package:leitor_manga/shared/search_app_bar.dart';
import 'package:leitor_manga/version/bloc/version_bloc.dart';
import 'package:pedantic/pedantic.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageStorageKey _lastMangaWithUpdateKey;
  PageStorageKey _allMangaWithUpdateKey;
  GlobalKey _searchKey;

  StreamController<String> _streamController;
  bool _searchMode;
  String _lastQuery;

  @override
  void initState() {
    _streamController = StreamController<String>.broadcast();
    _searchMode = false;
    _lastMangaWithUpdateKey = PageStorageKey('l');
    _allMangaWithUpdateKey = PageStorageKey('a');
    _searchKey = GlobalKey();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: SearchAppBar(
          streamController: _streamController,
          onSearchModeChanged: (bool searchMode) {
            setState(() {
              _searchMode = searchMode;
            });
          },
          appBar: AppBar(
            title: Text('Uai Mangás'),
            bottom: _searchMode
                ? null
                : TabBar(
                    tabs: [
                      Tab(text: 'Últimas atualizações'),
                      Tab(text: 'Todos'),
                    ],
                  ),
            leading: Builder(
              builder: (BuildContext context) {
                return DrawerCount();
              },
            ),
          ),
        ),
        drawer: HomeDrawer(),
        body: StreamBuilder<String>(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (!_searchMode) {
              var versionState = context.bloc<VersionBloc>().state;
              if (versionState is VersionLoaded) {
                unawaited(ChangelogService.openDialogFirstTime(
                    context, versionState.versionCode));
              }

              return TabBarView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: LastMangaWithUpdate(key: _lastMangaWithUpdateKey),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: MangaList(
                      key: _allMangaWithUpdateKey,
                      showCount: true,
                    ),
                  ),
                ],
              );
            }

            if (_lastQuery != snapshot.data) {
              _searchKey = GlobalKey();
              _allMangaWithUpdateKey =
                  PageStorageKey(_allMangaWithUpdateKey.value + '2');
            }

            _lastQuery = snapshot.data;

            return Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: MangaList(
                key: _searchKey,
                showCount: true,
                mangaName: snapshot.data,
              ),
            );
          },
        ),
      ),
    );
  }
}
