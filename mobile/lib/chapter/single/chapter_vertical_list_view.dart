import 'dart:async';
import 'dart:collection';
import 'package:diagonal_scrollview/diagonal_scrollview.dart';
import 'package:flutter/scheduler.dart';
import 'package:leitor_manga/chapter/single/page.dart' as manga_page;
import 'package:pedantic/pedantic.dart';
import 'package:quiver/collection.dart';

import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:leitor_manga/chapter/single/chapter.dto.dart';

import 'package:progress_dialog/progress_dialog.dart';

/// A listview for chapter pages
class ChapterVerticalListView extends StatefulWidget {
  ChapterVerticalListView(this.chapter, {Key key, this.chapterController})
      : super(key: key);

  final ChapterDto chapter;
  final ChapterController chapterController;

  @override
  _ChapterVerticalListViewState createState() =>
      _ChapterVerticalListViewState(chapter, controller: chapterController);
}

class _ChapterVerticalListViewState extends State<ChapterVerticalListView>
    with WidgetsBindingObserver {
  final Map<int, PageLoad> pageIsLoaded;
  final ChapterDto chapter;
  final ChapterController _controller;

  Map<int, GlobalKey> gloalKeyByPageIndex;

  ProgressDialog progressDialog;
  double _olderScrollPosition;
  Timer timerScaleChanged;

  _ChapterVerticalListViewState(this.chapter, {ChapterController controller})
      : _controller = controller ?? ChapterController(),
        pageIsLoaded = controller.pageIsLoaded;

  @override
  void initState() {
    _olderScrollPosition = 0;

    gloalKeyByPageIndex = HashMap();

    for (var i = 0; i < chapter.pages.length; i++) {
      pageIsLoaded[i] = PageLoad(
          i < 2 ? PageLoadStatus.IN_PROGRESS : PageLoadStatus.NOT_LOADED);
      gloalKeyByPageIndex[i] = GlobalKey();
    }

    _controller.initState(chapter);

    _controller.checkIfPageIsLoaded = _checkIfPageIsLoaded;

    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _loadImage(pageNumber) {
    var completer = Completer<void>();

    if (pageIsLoaded[pageNumber]._status == PageLoadStatus.NOT_LOADED) {
      pageIsLoaded[pageNumber].onPageLoadChanged = ((status) {
        if (status == PageLoadStatus.LOADED) {
          completer.complete();
          pageIsLoaded[pageNumber].onPageLoadChanged = null;
        }
      });

      setState(() {
        pageIsLoaded[pageNumber].status = PageLoadStatus.IN_PROGRESS;
      });
    } else {
      completer.complete();
    }

    return completer.future;
  }

  void _checkIfPageIsLoaded(
      int pageNumber, bool showDialog, VoidCallback callback) async {
    var completer = Completer<void>();

    var loadPreviousPage = pageNumber > 0 &&
        pageIsLoaded[pageNumber - 1].status == PageLoadStatus.NOT_LOADED;

    var loadNextPage = pageNumber + 1 < chapter.pages.length &&
        pageIsLoaded[pageNumber + 1].status == PageLoadStatus.NOT_LOADED;

    if (showDialog) {
      await progressDialog.show();
    }

    if (loadPreviousPage) {
      await _loadImage(pageNumber - 1);
    }

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (loadPreviousPage) {
        await _controller.scrollToPage(pageNumber - 1, updatePageNumber: false);
      }

      await _loadImage(pageNumber);
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await _controller.scrollToPage(pageNumber, updatePageNumber: true);
        completer.complete();
      });
    });

    unawaited(completer.future.then((_) async {
      if (loadNextPage) {
        unawaited(_loadImage(pageNumber + 1));
      }

      if (showDialog) {
        await progressDialog.hide();
      }

      callback();
    }));
  }

  Widget _getProgressBarForPage(containerHeight) {
    return Container(
      height: containerHeight,
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }

  void _informHeightAndInxOfPage(index) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (gloalKeyByPageIndex[index].currentContext != null) {
        RenderBox box =
            gloalKeyByPageIndex[index].currentContext.findRenderObject();
        if (box != null) {
          _controller._chapterLoaded(box.size.height, index);
        }
      }
    });
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _controller.recalculateHeightOfPages(gloalKeyByPageIndex);
      _controller.rebuildChaptersMap();
      _controller.goToPage(_controller.currentPage, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);

    var width = MediaQuery.of(context).size.width;

    return DiagonalScrollView(
      maxWidth: width,
      maxHeight: _controller.height + 60,
      minScale: 1,
      maxScale: 3,
      enableZoom: true,
      onScaleChanged: (double scale) {
        if (timerScaleChanged != null) {
          timerScaleChanged.cancel();
        }
        timerScaleChanged = Timer(Duration(seconds: 1), () {
          SchedulerBinding.instance.addPostFrameCallback((_) async {
            _controller.rebuildChaptersMap(scale: scale);
          });
        });
      },
      onScroll: (Offset offset) {
        var dy = offset.dy * -1;

        _controller.notifyScrollChange(dy);

        if (dy > _olderScrollPosition &&
            pageIsLoaded[_controller.currentPage].status ==
                PageLoadStatus.NOT_LOADED) {
          setState(() {
            pageIsLoaded[_controller.currentPage].status =
                PageLoadStatus.IN_PROGRESS;
          });
        } else if (dy > _olderScrollPosition &&
            _controller.currentPage + 1 < chapter.pages.length &&
            pageIsLoaded[_controller.currentPage + 1].status ==
                PageLoadStatus.NOT_LOADED) {
          setState(() {
            pageIsLoaded[_controller.currentPage + 1].status =
                PageLoadStatus.IN_PROGRESS;
          });
        } else if (dy < _olderScrollPosition &&
            _controller.currentPage - 1 > 0 &&
            pageIsLoaded[_controller.currentPage - 1].status ==
                PageLoadStatus.NOT_LOADED) {
          setState(() {
            pageIsLoaded[_controller.currentPage - 1].status =
                PageLoadStatus.IN_PROGRESS;
          });
        }

        _olderScrollPosition = dy;
      },
      onCreated: (DiagonalScrollViewController controller) {
        _controller.scrollController = controller;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          var widgets = <Widget>[];
          for (var index = 0; index < chapter.pages.length; index++) {
            var page = chapter.pages[index];

            widgets.add(pageIsLoaded[index].status == PageLoadStatus.NOT_LOADED
                ? _getProgressBarForPage(page.height)
                : manga_page.Page(
                    key: gloalKeyByPageIndex[index],
                    width: width,
                    page: page,
                    index: index,
                    loadingBuilder: (height) =>
                        _getProgressBarForPage(page.height),
                    loadStatusChanged: (LoadState status) {
                      switch (status) {
                        case LoadState.completed:
                          _informHeightAndInxOfPage(index);
                          pageIsLoaded[index].status = PageLoadStatus.LOADED;
                          break;
                        case LoadState.failed:
                          pageIsLoaded[index].status = PageLoadStatus.LOADED;
                          _informHeightAndInxOfPage(index);
                          break;
                        default:
                          break;
                      }
                    },
                  ));
          }

          return Column(
            children: widgets,
          );
        },
      ),
    );
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

typedef PageChangeListener = void Function(int, bool);
typedef ScrollChangeListener = void Function(double);

class ChapterController {
  ChapterDto chapter;
  final List<PageChangeListener> pageChangeListeners = [];
  final List<ScrollChangeListener> scrollChangeListeners = [];
  final Map<int, PageLoad> pageIsLoaded = <int, PageLoad>{};

  void Function(int value, bool showDialog, VoidCallback callback)
      checkIfPageIsLoaded;
  AvlTreeSet<ChapterTree> chaptersTree;

  DiagonalScrollViewController scrollController;

  ChapterController() {
    scrollChangeListeners.add((scroll) => _onScrollNotification(scroll));
  }

  int _currentPage = 0;
  double _height = 0;
  double get height => _height;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) {
    _currentPage = currentPage;
    _notifyPageChange(_currentPage);
  }

  void _notifyPageChange(int page) {
    pageChangeListeners
        .forEach((pageChangeListener) => pageChangeListener(page, page +1 == chapter.pages.length));
  }

  void addPageChangeListener(PageChangeListener pageChangeListener) {
    pageChangeListeners.add(pageChangeListener);
  }

  void notifyScrollChange(double scroll) {
    scrollChangeListeners
        .forEach((scrollChangeListener) => scrollChangeListener(scroll));
  }

  void addScrollChangeListener(ScrollChangeListener scrollChangeListener) {
    scrollChangeListeners.add(scrollChangeListener);
  }

  bool allPagesLoaded() {
    return pageIsLoaded.values
            .any((pageLoad) => pageLoad.status == PageLoadStatus.NOT_LOADED) ==
        false;
  }

  Future<void> scrollToPage(int pageNumber, {updatePageNumber = true}) {
    var completer = Completer<void>();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      rebuildChaptersMap();
      SchedulerBinding.instance.addPostFrameCallback((_) {
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

  Future<int> goToPage(int pageNumber, bool showDialog) async {
    var completer = Completer<int>();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      scrollToPage(pageNumber).then((_) async {
        if (checkIfPageIsLoaded != null) {
          var checkPageCompleter = Completer<void>();
          checkIfPageIsLoaded(pageNumber, showDialog, () {
            checkPageCompleter.complete();
          });
          await checkPageCompleter.future;
        }

        SchedulerBinding.instance.addPostFrameCallback((_) async {
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

  Future<int> nextPage() async {
    return goToPage(currentPage + 1, true);
  }

  Future<int> previousPage() async {
    return goToPage(currentPage - 1, true);
  }

  void recalculateHeightOfPages(Map<int, GlobalKey> gloalKeyByPageIndex) {
    for (var i = 0; i < chapter.pages.length; i++) {
      var page = chapter.pages[i];

      var currentContext = gloalKeyByPageIndex[i].currentContext;
      if (currentContext != null) {
        RenderBox box = currentContext.findRenderObject();

        page.height = box.size.height;
      }
    }
  }

  void _chapterLoaded(double height, int pageIndex) {
    chapter.pages[pageIndex].height = height;

    rebuildChaptersMap();
  }

  void rebuildChaptersMap({scale = 1}) {
    _height = 0;
    chaptersTree.clear();

    var currentPosition = 0.0;

    for (var i = 0; i < chapter.pages.length; i++) {
      var page = chapter.pages[i];
      chaptersTree.add(ChapterTree(currentPosition, i));
      page.height *= scale;
      currentPosition += page.height;
      _height += page.height;
    }
  }

  void _onScrollNotification(double dy) {
    var chapterTree = chaptersTree.nearest(ChapterTree(dy, -1),
        nearestOption: TreeSearch.GREATER_THAN);
    if (chapterTree != null) {
      currentPage = chapterTree.listIndex;
    }
  }

  void initState(ChapterDto chapter) {
    // scrollController = new ScrollController();
    chaptersTree = AvlTreeSet(comparator: (a, b) => a.compareTo(b));
    this.chapter = chapter;
  }
}

class PageLoad {
  PageLoadStatus _status;
  PageLoadStatus get status => _status;
  set status(PageLoadStatus status) {
    _status = status;

    if (onPageLoadChanged != null) {
      onPageLoadChanged(status);
    }
  }

  Function(PageLoadStatus status) onPageLoadChanged;

  PageLoad(PageLoadStatus status) : _status = status;
}

enum PageLoadStatus {
  LOADED,
  NOT_LOADED,
  IN_PROGRESS,
}
