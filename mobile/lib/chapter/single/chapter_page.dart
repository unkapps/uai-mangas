import 'package:extended_future_builder/extended_future_builder.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ExtendedFutureBuilder<ChapterDto>(
        futureResponseBuilder: () => service.getChapter(this.chapterId),
        ftrStarted: () {
            title = 'Carregando...';
        },
        ftrThen: (chapter) {
          setState(() {
            title = chapter.getTitle();
          });
        },
        ftrCatch: (err) {
          setState(() {
            title = 'Erro ao carregar :(';
          });
        },
        errorBuilder: (BuildContext context, error) {
          return Center(
            child: Text('Erro! Clique para tentar novamente.'),
          );
        },
        successBuilder: (BuildContext context, ChapterDto chapter) {
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
        },
      ),
    );
  }
}
