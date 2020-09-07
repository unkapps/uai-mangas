import 'package:admob_flutter/admob_flutter.dart';
import 'package:diagonal_scrollview/diagonal_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/uai_page.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview_controller.dart';
import 'package:leitor_manga/app/shared/admob/admob_ads_id.dart';
import 'package:leitor_manga/app/shared/admob/admob_banner_wrapper.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';

class PageVerticalListView extends StatefulWidget implements IPageListView {
  @override
  final ChapterSingleModel chapter;

  final ChapterSingleController chapterSingleController;

  final PageVerticalListviewController pageVerticalListviewController;

  PageVerticalListView({
    Key key,
    @required this.chapter,
    @required this.chapterSingleController,
    @required this.pageVerticalListviewController,
  }) : super(key: key);

  @override
  _PageVerticalListViewState createState() => _PageVerticalListViewState(
        controller: pageVerticalListviewController,
      );
}

class _PageVerticalListViewState extends State<PageVerticalListView> {
  final _adHeight = AdmobBannerSize.MEDIUM_RECTANGLE.height + 20.0;

  final PageVerticalListviewController controller;

  _PageVerticalListViewState({@required this.controller});

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return DiagonalScrollView(
      minScale: 1,
      maxScale: 5,
      enableZoom: true,
      onCreated: controller.setScrollController,
      onScroll: controller.scrollChanged,
      child: LayoutBuilder(
        builder: (context, constraints) {
          var widgets = <Widget>[];

          for (var i = 0; i < controller.pagesStore.length; i++) {
            var pageStore = controller.pagesStore[i];

            widgets.add(UaiPage(
              key: controller.globalKeyByPageIndex[i],
              pageStore: pageStore,
              index: i,
            ));
          }

          return GestureDetector(
            onTap: controller.onTap,
            child: Column(
              children: [
                _getAd(width),
                ...widgets,
                _getAd(width),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getAd(double width) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: _adHeight,
        width: width,
        child: AdmobBannerWrapper(
          adUnitId: AdmobIdsId.CHAPTER_PAGE,
          adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
          listener: (event, _) {
            if (event == AdmobAdEvent.loaded) {
              controller.adLoaded();
            }
          },
        ),
      ),
    );
  }
}
