import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:leitor_manga/author/author.dto.dart';
import 'package:leitor_manga/author/authors.dart';
import 'package:leitor_manga/category/categories.dart';
import 'package:leitor_manga/chapter/list/chapter_list.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';
import 'package:leitor_manga/shared/extended-future-builder.dart';

class MangaPage extends StatefulWidget {
  final MangaService service = MangaService();
  final int mangaId;

  MangaPage({Key key, @required this.mangaId}) : super(key: key);

  @override
  _MangaPageState createState() => _MangaPageState(mangaId: this.mangaId);
}

class _MangaPageState extends State<MangaPage> {
  final int mangaId;

  String _title;
  GlobalKey<ChapterListState> _chapterListPageKey;

  ScrollController _scrollController;

  _MangaPageState({@required this.mangaId});

  @override
  void initState() {
    _title = 'Carregando';

    _chapterListPageKey = GlobalKey();
    _scrollController = ScrollController();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ExtendedFutureBuilder<MangaDto>(
        futureResponseBuilder: () => widget.service.getManga(mangaId),
        ftrStarted: () {
          setState(() {
            _title = 'Carregando...';
          });
        },
        ftrThen: (manga) {
          setState(() {
            _title = manga.name;
          });
        },
        ftrCatch: (err) {
          setState(() {
            _title = 'Erro ao carregar :(';
          });
        },
        errorBuilder: (BuildContext context, error) {
          return Center(
            child: Text('Erro! Clique para tentar novamente.'),
          );
        },
        successBuilder: (BuildContext context, MangaDto manga) {
          var authors = List<AuthorDto>.from(manga.authors);
          authors.addAll(manga.artists);

          Size size = MediaQuery.of(context).size;

          return NotificationListener(
            child: ListView(
              controller: _scrollController,
              children: <Widget>[
                ExtendedImage.network(
                  manga.coverUrl,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topCenter,
                  height: size.height * 0.6,
                  width: size.width,
                  cache: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Authors(
                    authors: authors,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ExpandablePanel(
                    header: Text('Resumo'),
                    collapsed: Text(
                      manga.description,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                    ),
                    expanded: Text(
                      manga.description,
                      softWrap: true,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Categories(
                  categories: manga.categories,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Capitulos'),
                ),
                ChapterList(
                  qtyChapters: manga.qtyChapters,
                  key: _chapterListPageKey,
                ),
              ],
            ),
            onNotification: (ScrollNotification scrollInfo) {
              if (_chapterListPageKey.currentState != null) {
                return _chapterListPageKey.currentState.onNotification(
                    scrollInfo, _scrollController.position.maxScrollExtent);
              }
              return false;
            },
          );
        },
      ),
    );
  }
}
