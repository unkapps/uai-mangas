// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_horizontal_listview_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageHorizontalListviewController
    on _PageHorizontalListviewControllerBase, Store {
  Computed<int> _$totalPagesComputed;

  @override
  int get totalPages =>
      (_$totalPagesComputed ??= Computed<int>(() => super.totalPages,
              name: '_PageHorizontalListviewControllerBase.totalPages'))
          .value;

  final _$currentPageAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.currentPage');

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

  final _$zoomAtom = Atom(name: '_PageHorizontalListviewControllerBase.zoom');

  @override
  double get zoom {
    _$zoomAtom.reportRead();
    return super.zoom;
  }

  @override
  set zoom(double value) {
    _$zoomAtom.reportWrite(value, super.zoom, () {
      super.zoom = value;
    });
  }

  final _$pagesStoreAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.pagesStore');

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

  final _$pageControllerAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.pageController');

  @override
  PageController get pageController {
    _$pageControllerAtom.reportRead();
    return super.pageController;
  }

  @override
  set pageController(PageController value) {
    _$pageControllerAtom.reportWrite(value, super.pageController, () {
      super.pageController = value;
    });
  }

  final _$chapterAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.chapter');

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

  final _$shouldShowTwoAdAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.shouldShowTwoAd');

  @override
  bool get shouldShowTwoAd {
    _$shouldShowTwoAdAtom.reportRead();
    return super.shouldShowTwoAd;
  }

  @override
  set shouldShowTwoAd(bool value) {
    _$shouldShowTwoAdAtom.reportWrite(value, super.shouldShowTwoAd, () {
      super.shouldShowTwoAd = value;
    });
  }

  final _$showBarAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.showBar');

  @override
  bool get showBar {
    _$showBarAtom.reportRead();
    return super.showBar;
  }

  @override
  set showBar(bool value) {
    _$showBarAtom.reportWrite(value, super.showBar, () {
      super.showBar = value;
    });
  }

  final _$adEventAtom =
      Atom(name: '_PageHorizontalListviewControllerBase.adEvent');

  @override
  AdmobAdEvent get adEvent {
    _$adEventAtom.reportRead();
    return super.adEvent;
  }

  @override
  set adEvent(AdmobAdEvent value) {
    _$adEventAtom.reportWrite(value, super.adEvent, () {
      super.adEvent = value;
    });
  }

  final _$scrollToPageAsyncAction =
      AsyncAction('_PageHorizontalListviewControllerBase.scrollToPage');

  @override
  Future<void> scrollToPage(int pageNumber, {dynamic updatePageNumber = true}) {
    return _$scrollToPageAsyncAction.run(() =>
        super.scrollToPage(pageNumber, updatePageNumber: updatePageNumber));
  }

  final _$loadImageAsyncAction =
      AsyncAction('_PageHorizontalListviewControllerBase.loadImage');

  @override
  Future<void> loadImage(dynamic pageNumber) {
    return _$loadImageAsyncAction.run(() => super.loadImage(pageNumber));
  }

  final _$_PageHorizontalListviewControllerBaseActionController =
      ActionController(name: '_PageHorizontalListviewControllerBase');

  @override
  void init(ChapterSingleModel chapter) {
    final _$actionInfo = _$_PageHorizontalListviewControllerBaseActionController
        .startAction(name: '_PageHorizontalListviewControllerBase.init');
    try {
      return super.init(chapter);
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void loadPageStore(ChapterSingleModel chapter) {
    final _$actionInfo =
        _$_PageHorizontalListviewControllerBaseActionController.startAction(
            name: '_PageHorizontalListviewControllerBase.loadPageStore');
    try {
      return super.loadPageStore(chapter);
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  Future<int> goToPage(int pageNumber, bool showDialog) {
    final _$actionInfo = _$_PageHorizontalListviewControllerBaseActionController
        .startAction(name: '_PageHorizontalListviewControllerBase.goToPage');
    try {
      return super.goToPage(pageNumber, showDialog);
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  Future<int> nextPage() {
    final _$actionInfo = _$_PageHorizontalListviewControllerBaseActionController
        .startAction(name: '_PageHorizontalListviewControllerBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  Future<int> previousPage() {
    final _$actionInfo =
        _$_PageHorizontalListviewControllerBaseActionController.startAction(
            name: '_PageHorizontalListviewControllerBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void changeZoom(double zoom) {
    final _$actionInfo = _$_PageHorizontalListviewControllerBaseActionController
        .startAction(name: '_PageHorizontalListviewControllerBase.changeZoom');
    try {
      return super.changeZoom(zoom);
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void zoomIn() {
    final _$actionInfo = _$_PageHorizontalListviewControllerBaseActionController
        .startAction(name: '_PageHorizontalListviewControllerBase.zoomIn');
    try {
      return super.zoomIn();
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void zoomOut() {
    final _$actionInfo = _$_PageHorizontalListviewControllerBaseActionController
        .startAction(name: '_PageHorizontalListviewControllerBase.zoomOut');
    try {
      return super.zoomOut();
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  void adEventChanged(AdmobAdEvent adEvent) {
    final _$actionInfo =
        _$_PageHorizontalListviewControllerBaseActionController.startAction(
            name: '_PageHorizontalListviewControllerBase.adEventChanged');
    try {
      return super.adEventChanged(adEvent);
    } finally {
      _$_PageHorizontalListviewControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPage: ${currentPage},
zoom: ${zoom},
pagesStore: ${pagesStore},
pageController: ${pageController},
chapter: ${chapter},
shouldShowTwoAd: ${shouldShowTwoAd},
showBar: ${showBar},
adEvent: ${adEvent},
totalPages: ${totalPages}
    ''';
  }
}
