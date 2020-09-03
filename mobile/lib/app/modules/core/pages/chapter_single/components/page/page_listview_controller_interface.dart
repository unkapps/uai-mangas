import 'package:flutter/foundation.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/horizontal/page_horizontal_listview.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/horizontal/page_horizontal_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview_controller.dart';

abstract class IPageListViewController {
  int currentPage;

  int get totalPages;

  List<PageStore> pagesStore;

  ChapterSingleModel chapter;

  bool showBar;

  void init(ChapterSingleModel chapter);

  Future<void> scrollToPage(int pageNumber, {updatePageNumber = true});

  Future<void> loadImage(pageNumber);

  Future<int> goToPage(int pageNumber, bool showDialog);

  Future<int> nextPage();

  Future<int> previousPage();

  void changeZoom(double zoom);

  void zoomIn();

  void zoomOut();
}

class PageListViewUtils {
  static IPageListViewController getListViewControllerInstance(
      ReadingMode readingMode, ChapterSingleModel chapter) {
    return readingMode == ReadingMode.VERTICAL
        ? PageVerticalListviewController(chapter)
        : PageHorizontalListviewController(chapter);
  }

  static IPageListView getListViewInstance(
    ReadingMode readingMode, {
    @required ChapterSingleModel chapter,
    @required IPageListViewController pageListviewController,
    @required ChapterSingleController chapterSingleController,
  }) {
    return readingMode == ReadingMode.VERTICAL
        ? PageVerticalListView(
            chapter: chapter,
            chapterSingleController: chapterSingleController,
            pageVerticalListviewController:
                pageListviewController as PageVerticalListviewController,
          )
        : PageHorizontalListView(
            chapter: chapter,
            pageHorizontalListviewController:
                pageListviewController as PageHorizontalListviewController,
            chapterSingleController: chapterSingleController,
          );
  }
}
