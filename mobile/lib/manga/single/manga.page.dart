import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/chapter/list/chapter_list_page.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';

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
  Future<MangaDto> _future;
  GlobalKey<ChapterListPageState> _chapterListPageKey;

  ScrollController _scrollController;

  _MangaPageState({@required this.mangaId});

  @override
  void initState() {
    _title = 'Carregando';
    _future = widget.service.getManga(mangaId);
    _future.then((manga) {
      setState(() {
        _title = manga.name;
      });
    });

    _chapterListPageKey = GlobalKey();
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<MangaDto> snapshot) {
          if (snapshot.hasData) {
            var manga = snapshot.data;
            Size size = MediaQuery.of(context).size;

            return NotificationListener(
              child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  ExtendedImage.network(
                    manga.coverUrl,
                    fit: BoxFit.fitWidth,
                    height: size.height * 0.6,
                    width: size.width,
                    cache: true,
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
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Capitulos'),
                  ),
                  ChapterListPage(
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
          } else {
            debugPrint('snap has no data');
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
