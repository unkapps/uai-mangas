import 'package:admob_flutter/admob_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/horizontal/page_horizontal_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/uai_page.dart';
import 'package:leitor_manga/app/shared/admob/admob_ads_id.dart';
import 'package:leitor_manga/app/shared/admob/admob_banner_wrapper.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';

class PageHorizontalListView extends StatefulWidget implements IPageListView {
  @override
  final ChapterSingleModel chapter;

  final ChapterSingleController chapterSingleController;

  final PageHorizontalListviewController pageHorizontalListviewController;

  PageHorizontalListView({
    Key key,
    @required this.chapter,
    @required this.pageHorizontalListviewController,
    @required this.chapterSingleController,
  }) : super(key: key);

  @override
  _PageHorizontalListViewState createState() => _PageHorizontalListViewState(
        controller: pageHorizontalListviewController,
      );
}

class _PageHorizontalListViewState extends State<PageHorizontalListView> {
  final _adHeight = AdmobBannerSize.MEDIUM_RECTANGLE.height + 20.0;
  final PageHorizontalListviewController controller;

  _PageHorizontalListViewState({@required this.controller});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Observer(
      builder: (_) {
        return ExtendedImageGesturePageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.chapter.pages.length + 2,
          controller: controller.pageController,
          itemBuilder: (BuildContext context, int index) {
            var pageStore = controller.pagesStore[index];

            if (pageStore.adPage) {
              return _getAd(width);
            }

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

  Widget _getAd(double width) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: _adHeight,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Observer(
              builder: (_) {
                return Visibility(
                  visible: controller.adEvent == null ||
                      controller.adEvent == AdmobAdEvent.started,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
            Observer(
              builder: (_) {
                return Visibility(
                  visible: controller.adEvent == AdmobAdEvent.failedToLoad,
                  child: Center(child: Text('Erro ao carregar o anúncio.')),
                );
              },
            ),
            AdmobBannerWrapper(
              adUnitId: AdmobIdsId.CHAPTER_PAGE,
              adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
              listener: (event, _) {
                if (event == AdmobAdEvent.loaded ||
                    event == AdmobAdEvent.failedToLoad ||
                    event == AdmobAdEvent.started) {
                  controller.adEventChanged(event);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
