import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:leitor_manga/chapter/chapter.dto.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/chapter_bar.dart';
import 'package:leitor_manga/chapter/chapter_vertical_list_view.dart';

class ChapterPage extends StatefulWidget {
  final int chapterId;

  ChapterPage(this.chapterId, {Key key}) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState(this.chapterId);
}

class _ChapterPageState extends State<ChapterPage> {
  final ChapterService service = ChapterService();
  final int chapterId;

  Future<ChapterDto> _chapterFuture;
  ChapterController _chapterController;

  String title;
  int currentPage;

  _ChapterPageState(this.chapterId);

  @override
  void initState() {
    title = 'Carregando...';
    currentPage = 1;

    _chapterFuture = service.getChapter(this.chapterId);
    _chapterFuture.then((chapter) {
      setState(() {
        title = chapter.getTitle();
      });
    });
    _chapterController = ChapterController();
    _chapterController.addPageChangeListener((pageNumber) {
      setState(() {
        currentPage = pageNumber + 1;
      });
    });
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

            return Stack(children: <Widget>[
              ChapterVerticalListView(
                chapter,
                chapterController: _chapterController,
              ),
              Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: 0.8,
                  child: ChapterBar(chapter, _chapterController),
                ),
              ),
            ]);
          } else {
            debugPrint('snap has no data');
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
