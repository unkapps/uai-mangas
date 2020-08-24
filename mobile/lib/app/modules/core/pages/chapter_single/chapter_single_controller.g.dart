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

  final _$showBarAtom = Atom(name: '_ChapterSingleControllerBase.showBar');

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

  final _$loadChapterAsyncAction =
      AsyncAction('_ChapterSingleControllerBase.loadChapter');

  @override
  Future<void> loadChapter(int chapterId) {
    return _$loadChapterAsyncAction.run(() => super.loadChapter(chapterId));
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
  void markChapterAsReaded() {
    final _$actionInfo = _$_ChapterSingleControllerBaseActionController
        .startAction(name: '_ChapterSingleControllerBase.markChapterAsReaded');
    try {
      return super.markChapterAsReaded();
    } finally {
      _$_ChapterSingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void informHeightAndInxOfPage(int index) {
    final _$actionInfo =
        _$_ChapterSingleControllerBaseActionController.startAction(
            name: '_ChapterSingleControllerBase.informHeightAndInxOfPage');
    try {
      return super.informHeightAndInxOfPage(index);
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
  String toString() {
    return '''
chapter: ${chapter},
showBar: ${showBar},
chapterReaded: ${chapterReaded},
currentPage: ${currentPage},
pageTitle: ${pageTitle},
barOpacity: ${barOpacity}
    ''';
  }
}
