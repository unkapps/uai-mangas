import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_controller_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';
import 'package:mobx/mobx.dart';

part 'page_horizontal_listview_controller.g.dart';

class PageHorizontalListviewController = _PageHorizontalListviewControllerBase
    with _$PageHorizontalListviewController;

const double opacityChapterBar = 0.8;

abstract class _PageHorizontalListviewControllerBase
    with Store
    implements IPageListViewController {
  @override
  @observable
  int currentPage = 0;

  @observable
  double zoom = 1;

  @override
  @observable
  List<PageStore> pagesStore;

  @observable
  PageController pageController;

  @override
  @observable
  ChapterSingleModel chapter;

  @override
  @observable
  bool showBar = true;

  @override
  @action
  void init(ChapterSingleModel chapter) {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page.round();

      if (pagesStore[currentPage].status == PageLoadStatus.NOT_LOADED) {
        pagesStore[currentPage].setStatus(PageLoadStatus.IN_PROGRESS);
      } else if (currentPage + 1 < chapter.pages.length &&
          pagesStore[currentPage + 1].status == PageLoadStatus.NOT_LOADED) {
        pagesStore[currentPage + 1].setStatus(PageLoadStatus.IN_PROGRESS);
      } else if (currentPage - 1 > 0 &&
          pagesStore[currentPage - 1].status == PageLoadStatus.NOT_LOADED) {
        pagesStore[currentPage - 1].setStatus(PageLoadStatus.IN_PROGRESS);
      }
    });
  }

  @override
  @action
  void setPagesStore(List<PageStore> pagesStore) {
    this.pagesStore = pagesStore;
  }

  @override
  @action
  Future<void> scrollToPage(int pageNumber, {updatePageNumber = true}) async {}

  @override
  @action
  Future<void> loadImage(pageNumber) async {}

  @override
  @action
  // ignore: missing_return
  Future<int> goToPage(int pageNumber, bool showDialog) {
    pageController.jumpToPage(pageNumber);
  }

  @override
  @action
  Future<int> nextPage() {
    return goToPage(currentPage + 1, false);
  }

  @override
  @action
  Future<int> previousPage() {
    return goToPage(currentPage - 1, false);
  }

  @override
  @action
  void changeZoom(double zoom) {
    this.zoom = zoom;
  }

  @override
  @action
  void zoomIn() {
    zoom += 1;
  }

  @override
  @action
  void zoomOut() {
    zoom -= 1;
  }
}
