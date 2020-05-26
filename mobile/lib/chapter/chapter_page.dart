import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:leitor_manga/chapter/chapter.dto.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/chapter_vertical_list_view.dart';

class ChapterPage extends StatefulWidget {
  ChapterPage({Key key}) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  ChapterService service = ChapterService();

  Future<ChapterDto> _chapterFuture;
  var currentPage = 1;
  var title = 'Carregando...';

  @override
  void initState() {
    _chapterFuture = service.getChapter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder(
        future: _chapterFuture,
        builder: (BuildContext context, AsyncSnapshot<ChapterDto> snapshot) {
          if (snapshot.hasData) {
            ChapterDto chapter = snapshot.data;

            title = chapter.getTitle();

            return Stack(children: <Widget>[
              ChapterVerticalListView(
                chapter,
                onPageChange: (pageNumber) {
                  setState(() {
                    currentPage = pageNumber + 1;
                  });
                },
              ),
              Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          '$currentPage/${chapter.pages.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
