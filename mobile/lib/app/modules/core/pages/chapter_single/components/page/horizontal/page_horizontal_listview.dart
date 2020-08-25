import 'package:admob_flutter/admob_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/horizontal/page_horizontal_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/uai_page.dart';
import 'package:leitor_manga/app/shared/admob/admob_ads_id.dart';
import 'package:leitor_manga/app/shared/admob/admob_banner_wrapper.dart';

class PageHorizontalListView extends StatefulWidget implements IPageListView {
  @override
  final ChapterSingleModel chapter;

  PageHorizontalListView({Key key, @required this.chapter}) : super(key: key);

  @override
  _PageHorizontalListViewState createState() => _PageHorizontalListViewState();
}

class _PageHorizontalListViewState extends ModularState<PageHorizontalListView,
    PageHorizontalListviewController> {
  final _adHeight = AdmobBannerSize.MEDIUM_RECTANGLE.height + 20.0;

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
    var width = MediaQuery.of(context).size.width;

    return Observer(
      builder: (_) {
        final shouldShowTwoAd = widget.chapter.pages.length > PAGE_SECOND_AD;

        return ExtendedImageGesturePageView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.chapter.pages.length + 2,
          controller: controller.pageController,
          itemBuilder: (BuildContext context, int index) {
            if (index == 1 || (index == PAGE_SECOND_AD && shouldShowTwoAd)) {
              return _getAd(width);
            }

            var realIndex = index;

            if (index > PAGE_FIRST_AD) {
              if (index < PAGE_SECOND_AD) {
                realIndex -= 1;
              } else if (shouldShowTwoAd) {
                realIndex -= 2;
              }
            }

            var pageStore = controller.pagesStore[realIndex];

            return UaiPage(
              index: realIndex,
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
