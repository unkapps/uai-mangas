// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_single_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChapterSingleController on _ChapterSingleControllerBase, Store {
  Computed<int> _$currentPageComputed;

  @override
  int get currentPage =>
      (_$currentPageComputed ??= Computed<int>(() => super.currentPage,
              name: '_ChapterSingleControllerBase.currentPage'))
          .value;
  Computed<int> _$totalPagesComputed;

  @override
  int get totalPages =>
      (_$totalPagesComputed ??= Computed<int>(() => super.totalPages,
              name: '_ChapterSingleControllerBase.totalPages'))
          .value;
  Computed<bool> _$showBarComputed;

  @override
  bool get showBar => (_$showBarComputed ??= Computed<bool>(() => super.showBar,
          name: '_ChapterSingleControllerBase.showBar'))
      .value;
  Computed<String> _$pageTitleComputed;

  @override
  String get pageTitle =>
      (_$pageTitleComputed ??= Computed<String>(() => super.pageTitle,
              name: '_ChapterSingleControllerBase.pageTitle'))
          .value;
  Computed<double> _$barOpacityComputed;

  @override
  double get barOpacity =>
      (_$barOpacityComputed ??= Computed<double>(() => super.barOpacity,
              name: '_ChapterSingleControllerBase.barOpacity'))
          .value;

  final _$pageListViewControllerAtom =
      Atom(name: '_ChapterSingleControllerBase.pageListViewController');

  @override
  IPageListViewController get pageListViewController {
    _$pageListViewControllerAtom.reportRead();
    return super.pageListViewController;
  }

  @override
  set pageListViewController(IPageListViewController value) {
    _$pageListViewControllerAtom
        .reportWrite(value, super.pageListViewController, () {
      super.pageListViewController = value;
    });
  }

  final _$chapterAtom = Atom(name: '_ChapterSingleControllerBase.chapter');

  @override
  ObservableFuture<ChapterSingleModel> get chapter {
    _$chapterAtom.reportRead();
    return super.chapter;
  }

  @override
  set chapter(ObservableFuture<ChapterSingleModel> value) {
    _$chapterAtom.reportWrite(value, super.chapter, () {
      super.chapter = value;
    });
  }

  final _$chapterReadedAtom =
      Atom(name: '_ChapterSingleControllerBase.chapterReaded');

  @override
  bool get chapterReaded {
    _$chapterReadedAtom.reportRead();
    return super.chapterReaded;
  }

  @override
  set chapterReaded(bool value) {
    _$chapterReadedAtom.reportWrite(value, super.chapterReaded, () {
      super.chapterReaded = value;
    });
  }

  final _$readingModeAtom =
      Atom(name: '_ChapterSingleControllerBase.readingMode');

  @override
  ReadingMode get readingMode {
    _$readingModeAtom.reportRead();
    return super.readingMode;
  }

  @override
  set readingMode(ReadingMode value) {
    _$readingModeAtom.reportWrite(value, super.readingMode, () {
      super.readingMode = value;
    });
  }

  final _$loadChapterAsyncAction =
      AsyncAction('_ChapterSingleControllerBase.loadChapter');

  @override
  Future<void> loadChapter(int chapterId) {
    return _$loadChapterAsyncAction.run(() => super.loadChapter(chapterId));
  }

  final _$initChapterAsyncAction =
      AsyncAction('_ChapterSingleControllerBase.initChapter');

  @override
  Future<void> initChapter() {
    return _$initChapterAsyncAction.run(() => super.initChapter());
  }

  final _$markChapterAsReadedAsyncAction =
      AsyncAction('_ChapterSingleControllerBase.markChapterAsReaded');

  @override
  Future<void> markChapterAsReaded() {
    return _$markChapterAsReadedAsyncAction
        .run(() => super.markChapterAsReaded());
  }

  final _$goToPageAsyncAction =
      AsyncAction('_ChapterSingleControllerBase.goToPage');

  @override
  Future<void> goToPage(int pageNumber, bool showDialog) {
    return _$goToPageAsyncAction
        .run(() => super.goToPage(pageNumber, showDialog));
  }

  final _$_ChapterSingleControllerBaseActionController =
      ActionController(name: '_ChapterSingleControllerBase');

  @override
  void nextPage() {
    final _$actionInfo = _$_ChapterSingleControllerBaseActionController
        .startAction(name: '_ChapterSingleControllerBase.nextPage');
    try {
      return super.nextPage();
    } finally {
      _$_ChapterSingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void previousPage() {
    final _$actionInfo = _$_ChapterSingleControllerBaseActionController
        .startAction(name: '_ChapterSingleControllerBase.previousPage');
    try {
      return super.previousPage();
    } finally {
      _$_ChapterSingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void didChangeMetrics() {
    final _$actionInfo = _$_ChapterSingleControllerBaseActionController
        .startAction(name: '_ChapterSingleControllerBase.didChangeMetrics');
    try {
      return super.didChangeMetrics();
    } finally {
      _$_ChapterSingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleReadingMode() {
    final _$actionInfo = _$_ChapterSingleControllerBaseActionController
        .startAction(name: '_ChapterSingleControllerBase.toggleReadingMode');
    try {
      return super.toggleReadingMode();
    } finally {
      _$_ChapterSingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setReadingMode(ReadingMode readingMode, {dynamic saveOnShared = true}) {
    final _$actionInfo = _$_ChapterSingleControllerBaseActionController
        .startAction(name: '_ChapterSingleControllerBase.setReadingMode');
    try {
      return super.setReadingMode(readingMode, saveOnShared: saveOnShared);
    } finally {
      _$_ChapterSingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageListViewController: ${pageListViewController},
chapter: ${chapter},
chapterReaded: ${chapterReaded},
readingMode: ${readingMode},
currentPage: ${currentPage},
totalPages: ${totalPages},
showBar: ${showBar},
pageTitle: ${pageTitle},
barOpacity: ${barOpacity}
    ''';
  }
}
