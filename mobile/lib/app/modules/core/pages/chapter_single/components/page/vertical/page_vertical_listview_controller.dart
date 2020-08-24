import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';
import 'package:mobx/mobx.dart';
import 'package:pedantic/pedantic.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:quiver/collection.dart';
import 'package:diagonal_scrollview/diagonal_scrollview.dart';
import 'package:leitor_manga/app/shared/material_builder.dart'
    as material_builder;

part 'page_vertical_listview_controller.g.dart';

class PageVerticalListviewController = _PageVerticalListviewControllerBase
    with _$PageVerticalListviewController;

const double opacityChapterBar = 0.8;

abstract class _PageVerticalListviewControllerBase with Store {
  @observable
  double height;

  @observable
  int currentPage = 0;

  @observable
  List<PageStore> pagesStore;

  @observable
  AvlTreeSet<ChapterTree> chaptersTree;

  @observable
  DiagonalScrollViewController scrollController;

  @observable
  double olderScrollPosition;

  @observable
  ChapterSingleModel chapter;

  @observable
  Map<int, GlobalKey> globalKeyByPageIndex;

  @observable
  ProgressDialog progressDialog;

  @observable
  bool showBar = true;

  AvlTreeSet<ChapterTree> _newAvl() {
    return AvlTreeSet<ChapterTree>(comparator: (a, b) => a.compareTo(b));
  }

  @action
  void init(ChapterSingleModel chapter) {
    height = 0;
    olderScrollPosition = 0;
    chaptersTree = null;
    this.chapter = chapter;
    globalKeyByPageIndex = HashMap();

    for (var i = 0; i < chapter.pages.length; i++) {
      globalKeyByPageIndex[i] = GlobalKey();
    }
  }

  @action
  void setScrollController(DiagonalScrollViewController scrollController) {
    this.scrollController = scrollController;
  }

  @action
  void setPagesStore(List<PageStore> pagesStore) {
    this.pagesStore = pagesStore;
  }

  @action
  void scrollChanged(Offset offset) {
    var dy = offset.dy * -1;
    var qtyPages = chapter.pages.length;

    if (dy != olderScrollPosition) {
      onScrollNotification(dy);

      if (dy > olderScrollPosition &&
          pagesStore[currentPage].status == PageLoadStatus.NOT_LOADED) {
        pagesStore[currentPage].setStatus(PageLoadStatus.IN_PROGRESS);
      } else if (dy > olderScrollPosition &&
          currentPage + 1 < qtyPages &&
          pagesStore[currentPage + 1].status == PageLoadStatus.NOT_LOADED) {
        pagesStore[currentPage + 1].setStatus(PageLoadStatus.IN_PROGRESS);
      } else if (dy < olderScrollPosition &&
          currentPage - 1 > 0 &&
          pagesStore[currentPage - 1].status == PageLoadStatus.NOT_LOADED) {
        pagesStore[currentPage - 1].setStatus(PageLoadStatus.IN_PROGRESS);
      }

      showBar = olderScrollPosition > dy;

      olderScrollPosition = dy;
    }
  }

  @action
  void onScrollNotification(double dy) {
    var chapterTree = chaptersTree.nearest(ChapterTree(dy, -1),
        nearestOption: TreeSearch.NEAREST);
    if (chapterTree != null) {
      currentPage = chapterTree.listIndex;
    }
  }

  @action
  void chapterLoaded(double height, int pageIndex) {
    chapter.pages[pageIndex].height = height;

    rebuildChaptersMap();
  }

  @action
  void informHeightAndInxOfPage(index) {
    if (globalKeyByPageIndex[index].currentContext != null) {
      RenderBox box =
          globalKeyByPageIndex[index].currentContext.findRenderObject();
      if (box != null) {
        chapterLoaded(box.size.height, index);
      }
    }
  }

  @action
  void rebuildChaptersMap({scale = 1}) {
    height = 0;

    var chaptersTree = _newAvl();

    var currentPosition = 0.0;

    for (var i = 0; i < chapter.pages.length; i++) {
      var page = chapter.pages[i];
      chaptersTree.add(ChapterTree(currentPosition, i));
      page.height *= scale;
      currentPosition += page.height;
      height += page.height;
    }

    this.chaptersTree = chaptersTree;
  }

  @action
  void recalculateHeightOfPages() {
    for (var i = 0; i < chapter.pages.length; i++) {
      var page = chapter.pages[i];

      var currentContext = globalKeyByPageIndex[i].currentContext;
      if (currentContext != null) {
        RenderBox box = currentContext.findRenderObject();

        page.height = box.size.height;
      }
    }
  }

  @action
  Future<void> scrollToPage(int pageNumber, {updatePageNumber = true}) {
    var completer = Completer<void>();
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      rebuildChaptersMap();
      SchedulerBinding.instance.scheduleFrameCallback((_) {
        scrollController.moveTo(
            location: Offset(
                0,
                chaptersTree
                    .firstWhere((page) => page.listIndex == pageNumber)
                    .position));

        if (updatePageNumber) {
          currentPage = pageNumber;
        }
        completer.complete();
      });
    });

    return completer.future;
  }

  @action
  Future<void> loadImage(pageNumber) async {
    var completer = Completer<void>();

    if (pagesStore[pageNumber].status == PageLoadStatus.NOT_LOADED) {
      pagesStore[pageNumber].status = PageLoadStatus.IN_PROGRESS;

      var checkPageCompleter = Completer<void>();
      final dispose = when(
          (_) => pagesStore[pageNumber].status == PageLoadStatus.LOADED, () {
        checkPageCompleter.complete();
      });

      await checkPageCompleter.future;

      dispose();

      completer.complete();
    } else {
      completer.complete();
    }

    return completer.future;
  }

  @action
  Future<void> _createProgressBar() async {
    progressDialog = ProgressDialog(material_builder.context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    await progressDialog.show();
  }

  Future<void> _destroyProgressBar() async {
    await progressDialog.hide();
    progressDialog = null;
  }

  @action
  Future<void> checkIfPageIsLoaded(int pageNumber, bool showDialog) async {
    var completerPrincipalPage = Completer<void>();
    var completer = Completer<void>();

    var loadPreviousPage = pageNumber > 0 &&
        pagesStore[pageNumber - 1].status == PageLoadStatus.NOT_LOADED;

    var loadNextPage = pageNumber + 1 < chapter.pages.length &&
        pagesStore[pageNumber + 1].status == PageLoadStatus.NOT_LOADED;

    if (showDialog) {
      await _createProgressBar();
    }

    if (loadPreviousPage) {
      await loadImage(pageNumber - 1);
    }

    SchedulerBinding.instance.scheduleFrameCallback((_) async {
      if (loadPreviousPage) {
        await scrollToPage(pageNumber - 1, updatePageNumber: false);
      }

      await loadImage(pageNumber);
      SchedulerBinding.instance.scheduleFrameCallback((_) async {
        await scrollToPage(pageNumber, updatePageNumber: true);
        completerPrincipalPage.complete();
      });
    });

    unawaited(completerPrincipalPage.future.then((_) async {
      if (loadNextPage) {
        unawaited(loadImage(pageNumber + 1));
      }

      if (showDialog) {
        await _destroyProgressBar();
      }

      completer.complete();
    }));

    return completer.future;
  }

  Future<int> goToPage(int pageNumber, bool showDialog) async {
    var completer = Completer<int>();

    SchedulerBinding.instance.scheduleFrameCallback((_) {
      scrollToPage(pageNumber).then((_) async {
        await checkIfPageIsLoaded(pageNumber, showDialog);

        SchedulerBinding.instance.scheduleFrameCallback((_) async {
          chaptersTree.clear();
          rebuildChaptersMap();
          unawaited(scrollToPage(pageNumber).then((_) {
            completer.complete();
          }));
        });
      });
    });

    return completer.future;
  }

  @action
  Future<int> nextPage() async {
    return goToPage(currentPage + 1, true);
  }

  @action
  Future<int> previousPage() async {
    return goToPage(currentPage - 1, true);
  }

  @action
  void changeZoom(double zoom) {
    scrollController.moveTo(
      scale: zoom,
      location: scrollController.getPosition(),
    );
  }

  @action
  void zoomIn() {
    changeZoom(scrollController.getScale() + 1);
  }

  @action
  void zoomOut() {
    changeZoom(scrollController.getScale() - 1);
  }

  @action
  void adLoaded() {
    recalculateHeightOfPages();
    rebuildChaptersMap();
  }
}

class ChapterTree implements Comparable {
  int listIndex;
  double position;

  ChapterTree(this.position, this.listIndex);

  @override
  int compareTo(other) {
    if (other is ChapterTree) {
      return position.compareTo(other.position);
    }

    return position.compareTo(other);
  }
}
