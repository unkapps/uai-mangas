import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/single/chapter_bar.dart';
import 'package:leitor_manga/chapter/single/chapter_vertical_list_view.dart';

const double _opacityChapterBar = 0.8;

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
  double _oldScroll;
  double _opacity;

  _ChapterPageState(this.chapterId);

  @override
  void initState() {
    title = 'Carregando...';
    currentPage = 1;
    _oldScroll = 0;
    _opacity = _opacityChapterBar;

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
    _chapterController.addScrollChangeListener((scroll) {
      var scrollYEnd =
          _chapterController.scrollController.getContainerSize().height +
              scroll;
      var childSize =
          _chapterController.scrollController.getChildSize().height + 40;
      var endOfScroll =
          scrollYEnd > childSize && _chapterController.allPagesLoaded();

      setState(() {
        if (!endOfScroll && scroll > _oldScroll + 2) {
          _opacity = 0;
        } else if (endOfScroll || scroll < _oldScroll - 2) {
          _opacity = _opacityChapterBar;
        }

        _oldScroll = scroll;
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
                  opacity: _opacity,
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
