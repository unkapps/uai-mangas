import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/horizontal/page_horizontal_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/uai_page.dart';

class PageHorizontalListView extends StatefulWidget implements IPageListView {
  @override
  final ChapterSingleModel chapter;

  PageHorizontalListView({Key key, @required this.chapter}) : super(key: key);

  @override
  _PageHorizontalListViewState createState() => _PageHorizontalListViewState();
}

class _PageHorizontalListViewState extends ModularState<PageHorizontalListView,
    PageHorizontalListviewController> {
  @override
  void initState() {
    controller.init(widget.chapter);
    _initPagesStore();
    super.initState();
  }

  void _initPagesStore() {
    var i = 0;
    controller.setPagesStore(widget.chapter.pages
        .map((page) => PageStore(page, (i++ < 3)))
        .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return ExtendedImageGesturePageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.chapter.pages.length,
          controller: controller.pageController,
          itemBuilder: (BuildContext context, int index) {
            var pageStore = controller.pagesStore[index];

            return UaiPage(
              index: index,
              pageStore: pageStore,
              allowZoom: true,
              initialZoom: controller.zoom,
            );
          },
        );
      },
    );
  }
}
