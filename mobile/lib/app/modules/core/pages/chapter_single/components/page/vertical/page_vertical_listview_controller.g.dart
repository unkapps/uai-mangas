// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_vertical_listview_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageVerticalListviewController
    on _PageVerticalListviewControllerBase, Store {
  final _$heightAtom = Atom(name: '_PageVerticalListviewControllerBase.height');

  @override
  double get height {
    _$heightAtom.reportRead();
    return super.height;
  }

  @override
  set height(double value) {
    _$heightAtom.reportWrite(value, super.height, () {
      super.height = value;
    });
  }

  final _$currentPageAtom =
      Atom(name: '_PageVerticalListviewControllerBase.currentPage');

  @override
  int get currentPage {
    _$currentPageAtom.reportRead();
    return super.currentPage;
  }

  @override
  set currentPage(int value) {
    _$currentPageAtom.reportWrite(value, super.currentPage, () {
      super.currentPage = value;
    });
  }

  final _$pagesStoreAtom =
      Atom(name: '_PageVerticalListviewControllerBase.pagesStore');

  @override
  List<PageStore> get pagesStore {
    _$pagesStoreAtom.reportRead();
    return super.pagesStore;
  }

  @override
  set pagesStore(List<PageStore> value) {
    _$pagesStoreAtom.reportWrite(value, super.pagesStore, () {
      super.pagesStore = value;
    });
  }

  final _$chaptersTreeAtom =
      Atom(name: '_PageVerticalListviewControllerBase.chaptersTree');

  @override
  AvlTreeSet<ChapterTree> get chaptersTree {
    _$chaptersTreeAtom.reportRead();
    return super.chaptersTree;
  }

  @override
  set chaptersTree(AvlTreeSet<ChapterTree> value) {
    _$chaptersTreeAtom.reportWrite(value, super.chaptersTree, () {
      super.chaptersTree = value;
    });
  }

  final _$scrollControllerAtom =
      Atom(name: '_PageVerticalListviewControllerBase.scrollController');

  @override
  DiagonalScrollViewController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(DiagonalScrollViewController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  final _$olderScrollPositionAtom =
      Atom(name: '_PageVerticalListviewControllerBase.olderScrollPosition');

  @override
  double get olderScrollPosition {
    _$olderScrollPositionAtom.reportRead();
    return super.olderScrollPosition;
  }

  @override
  set olderScrollPosition(double value) {
    _$olderScrollPositionAtom.reportWrite(value, super.olderScrollPosition, () {
      super.olderScrollPosition = value;
    });
  }

  final _$chapterAtom =
      Atom(name: '_PageVerticalListviewControllerBase.chapter');

  @override
  ChapterSingleModel get chapter {
    _$chapterAtom.reportRead();
    return super.chapter;
  }

  @override
  set chapter(ChapterSingleModel value) {
    _$chapterAtom.reportWrite(value, super.chapter, () {
      super.chapter = value;
    });
  }

  final _$globalKeyByPageIndexAtom =
      Atom(name: '_PageVerticalListviewControllerBase.globalKeyByPageIndex');

  @override
  Map<int, GlobalKey<State<StatefulWidget>>> get globalKeyByPageIndex {
    _$globalKeyByPageIndexAtom.reportRead();
    return super.globalKeyByPageIndex;
  }

  @override
  set globalKeyByPageIndex(Map<int, GlobalKey<State<StatefulWidget>>> value) {
    _$globalKeyByPageIndexAtom.reportWrite(value, super.globalKeyByPageIndex,
        () {
      super.globalKeyByPageIndex = value;
    });
  }

  final _$progressDialogAtom =
      Atom(name: '_PageVerticalListviewControllerBase.progressDialog');

  @override
  ProgressDialog get progressDialog {
    _$progressDialogAtom.reportRead();
    return super.progressDialog;
  }

  @override
  set progressDialog(ProgressDialog value) {
    _$progressDialogAtom.reportWrite(value, super.progressDialog, () {
      super.progressDialog = value;
    });
  }

  final _$loadImageAsyncAction =
      AsyncAction('_PageVerticalListviewControllerBase.loadImage');

  @override
  Future<void> loadImage(dynamic pageNumber) {
    return _$loadImageAsyncAction.run(() => super.loadImage(pageNumber));
  }

  final _$_createProgressBarAsyncAction =
      AsyncAction('_PageVerticalListviewControllerBase._createProgressBar');

  @override
  Future<void> _createProgressBar() {
    return _$_createProgressBarAsyncAction
        .run(() => super._createProgressBar());
  }

  final _$checkIfPageIsLoadedAsyncAction =
      AsyncAction('_PageVerticalListviewControllerBase.checkIfPageIsLoaded');

  @override
  Future<void> checkIfPageIsLoaded(int pageNumber, bool showDialog) {
    return _$checkIfPageIsLoadedAsyncAction
        .run(() => super.checkIfPageIsLoaded(pageNumber, showDialog));
  }

  final _$nextPageAsyncAction =
      AsyncAction('_PageVerticalListviewControllerBase.nextPage');

  @override
  Future<int> nextPage() {
    return _$nextPageAsyncAction.run(() => super.nextPage());
  }

  final _$previousPageAsyncAction =
      AsyncAction('_PageVerticalListviewControllerBase.previousPage');

  @override
  Future<int> previousPage() {
    return _$previousPageAsyncAction.run(() => super.previousPage());
  }

  final _$_PageVerticalListviewControllerBaseActionController =
      ActionController(name: '_PageVerticalListviewControllerBase');

  @override
  void init(ChapterSingleModel chapter) {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.init');
    try {
      return super.init(chapter);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setScrollController(DiagonalScrollViewController scrollController) {
    final _$actionInfo =
        _$_PageVerticalListviewControllerBaseActionController.startAction(
            name: '_PageVerticalListviewControllerBase.setScrollController');
    try {
      return super.setScrollController(scrollController);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void setPagesStore(List<PageStore> pagesStore) {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.setPagesStore');
    try {
      return super.setPagesStore(pagesStore);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void scrollChanged(Offset offset) {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.scrollChanged');
    try {
      return super.scrollChanged(offset);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void onScrollNotification(double dy) {
    final _$actionInfo =
        _$_PageVerticalListviewControllerBaseActionController.startAction(
            name: '_PageVerticalListviewControllerBase.onScrollNotification');
    try {
      return super.onScrollNotification(dy);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void chapterLoaded(double height, int pageIndex) {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.chapterLoaded');
    try {
      return super.chapterLoaded(height, pageIndex);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void informHeightAndInxOfPage(dynamic index) {
    final _$actionInfo =
        _$_PageVerticalListviewControllerBaseActionController.startAction(
            name:
                '_PageVerticalListviewControllerBase.informHeightAndInxOfPage');
    try {
      return super.informHeightAndInxOfPage(index);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void rebuildChaptersMap({dynamic scale = 1}) {
    final _$actionInfo =
        _$_PageVerticalListviewControllerBaseActionController.startAction(
            name: '_PageVerticalListviewControllerBase.rebuildChaptersMap');
    try {
      return super.rebuildChaptersMap(scale: scale);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void recalculateHeightOfPages() {
    final _$actionInfo =
        _$_PageVerticalListviewControllerBaseActionController.startAction(
            name:
                '_PageVerticalListviewControllerBase.recalculateHeightOfPages');
    try {
      return super.recalculateHeightOfPages();
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  Future<void> scrollToPage(int pageNumber, {dynamic updatePageNumber = true}) {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.scrollToPage');
    try {
      return super.scrollToPage(pageNumber, updatePageNumber: updatePageNumber);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeZoom(double zoom) {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.changeZoom');
    try {
      return super.changeZoom(zoom);
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void zoomIn() {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.zoomIn');
    try {
      return super.zoomIn();
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void zoomOut() {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.zoomOut');
    try {
      return super.zoomOut();
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void adLoaded() {
    final _$actionInfo = _$_PageVerticalListviewControllerBaseActionController
        .startAction(name: '_PageVerticalListviewControllerBase.adLoaded');
    try {
      return super.adLoaded();
    } finally {
      _$_PageVerticalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
height: ${height},
currentPage: ${currentPage},
pagesStore: ${pagesStore},
chaptersTree: ${chaptersTree},
scrollController: ${scrollController},
olderScrollPosition: ${olderScrollPosition},
chapter: ${chapter},
globalKeyByPageIndex: ${globalKeyByPageIndex},
progressDialog: ${progressDialog}
    ''';
  }
}
