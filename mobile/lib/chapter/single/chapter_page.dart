import 'package:extended_future_builder/extended_future_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/chapter/chapter_readed/bloc/global_chapter_readed_bloc.dart';

import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:leitor_manga/chapter/single/chapter_bar.dart';
import 'package:leitor_manga/chapter/single/chapter_vertical_list_view.dart';

const double _opacityChapterBar = 0.8;

enum Actions { zoom_in, zoom_out, zoom_reset }

class ChapterPage extends StatefulWidget {
  final int mangaId;
  final int chapterId;

  ChapterPage({@required this.mangaId, @required this.chapterId, Key key})
      : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  static final getIt = GetIt.instance;
  final ChapterService service = getIt<ChapterService>();

  ChapterController _chapterController;

  String title;
  int currentPage;
  double _oldScroll;
  double _opacity;

  bool _chapterReaded;

  _ChapterPageState();

  @override
  void initState() {
    title = 'Carregando...';
    currentPage = 1;
    _oldScroll = 0;
    _opacity = _opacityChapterBar;

    _chapterController = ChapterController();
    _chapterController.addPageChangeListener((pageNumber, isPageEnd) {
      setState(() {
        currentPage = pageNumber + 1;
      });

      if (isPageEnd && !_chapterReaded) {
        setState(() {
          _chapterReaded = true;
        });
        context.bloc<GlobalChapterReadedBloc>().add(
            GlobalChangeChapterReadedEvent(widget.chapterId, pageNumber,
                isLast: isPageEnd));
      }
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
        actions: <Widget>[
          PopupMenuButton<Actions>(
            onSelected: (Actions action) {
              setState(() {
                if (action == Actions.zoom_in) {
                  _chapterController.zoomIn();
                } else if (action == Actions.zoom_out) {
                  _chapterController.zoomOut();
                } else if (action == Actions.zoom_reset) {
                  _chapterController.resetZoom();
                }
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Actions>>[
              const PopupMenuItem<Actions>(
                value: Actions.zoom_in,
                child: Text('Aumentar zoom'),
              ),
              const PopupMenuItem<Actions>(
                value: Actions.zoom_out,
                child: Text('Diminuir zoom'),
              ),
              const PopupMenuItem<Actions>(
                value: Actions.zoom_reset,
                child: Text('Resetar zoom'),
              ),
            ],
          )
        ],
      ),
      body: ExtendedFutureBuilder<ChapterDto>(
        futureResponseBuilder: () => service.getChapter(widget.chapterId),
        ftrStarted: () {
          title = 'Carregando...';
        },
        ftrThen: (chapter) {
          setState(() {
            title = chapter.getTitle();
            _chapterReaded = chapter.readed;
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
