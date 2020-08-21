import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/chapter_bar.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview.dart';
import 'package:mobx/mobx.dart';

class ChapterSinglePage extends StatefulWidget {
  final int mangaId;
  final int chapterId;

  ChapterSinglePage({
    @required this.mangaId,
    @required this.chapterId,
    Key key,
  }) : super(key: key);

  @override
  _ChapterSinglePageState createState() => _ChapterSinglePageState();
}

class _ChapterSinglePageState
    extends ModularState<ChapterSinglePage, ChapterSingleController> {
  @override
  void initState() {
    controller.loadChapter(widget.chapterId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(controller.pageTitle);
        }),
      ),
      body: Observer(
        builder: (_) {
          if (controller.chapter.status == FutureStatus.rejected) {
            return InkWell(
              child: Center(
                child: Text('Erro! Clique para tentar novamente.'),
              ),
              onTap: () {
                controller.loadChapter(widget.mangaId);
              },
            );
          }

          if (controller.chapter.status == FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.chapter.status == FutureStatus.fulfilled) {
            return _buildSuccess(context, controller.chapter.value);
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, ChapterSingleModel chapter) {
    IPageListView pageListView = PageVerticalListView(
      chapter: chapter,
    );

    return Stack(children: <Widget>[
      pageListView,
      Positioned(
        bottom: 0,
        child: Opacity(
          opacity: controller.barOpacity,
          child: ChapterBar(
            chapter,
            onChapterChange: (movedFoward) {
              if (movedFoward) {
                controller.markChapterAsReaded();
              }
            },
          ),
        ),
      ),
    ]);
  }
}
