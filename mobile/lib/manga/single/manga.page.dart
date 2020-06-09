import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/chapter/list/chapter_list_page.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';

class MangaPage extends StatefulWidget {
  final MangaService service = MangaService();

  MangaPage({Key key}) : super(key: key);

  @override
  _MangaPageState createState() => _MangaPageState();
}

class _MangaPageState extends State<MangaPage> {
  String _title;
  Future<MangaDto> _future;
  GlobalKey<ChapterListPageState> _chapterListPageKey;

  ScrollController _scrollController;

  @override
  void initState() {
    _title = 'Carregando';
    _future = widget.service.getManga(577);
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
            return NotificationListener(
              child: ListView(
                controller: _scrollController,
                children: <Widget>[
                  ExtendedImage.network(
                    manga.coverUrl,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '${manga.description}',
                      textAlign: TextAlign.justify,
                    ),
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
