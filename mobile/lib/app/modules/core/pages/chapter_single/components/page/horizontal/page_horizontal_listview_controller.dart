import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_controller_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';
import 'package:mobx/mobx.dart';

part 'page_horizontal_listview_controller.g.dart';

class PageHorizontalListviewController = _PageHorizontalListviewControllerBase
    with _$PageHorizontalListviewController;

const double opacityChapterBar = 0.8;

const PAGE_FIRST_AD = 1;
const PAGE_SECOND_AD = 6;

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

  @observable
  AdmobAdEvent adEvent;

  @computed
  @override
  int get totalPages {
    if (chapter.pages.length > PAGE_SECOND_AD) {
      return chapter.pages.length + 2;
    }

    return chapter.pages.length + 1;
  }

  @override
  @action
  void init(ChapterSingleModel chapter) {
    this.chapter = chapter;

    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page.round();

      if (currentPage > pagesStore.length - 1) {
        return;
      }

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

  @action
  void adEventChanged(AdmobAdEvent adEvent) {
    this.adEvent = adEvent;
  }
}
