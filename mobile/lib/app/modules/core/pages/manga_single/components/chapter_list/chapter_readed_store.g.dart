// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_readed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChapterReadedStore on _ChapterReadedStoreBase, Store {
  Computed<bool> _$loadedComputed;

  @override
  bool get loaded => (_$loadedComputed ??= Computed<bool>(() => super.loaded,
          name: '_ChapterReadedStoreBase.loaded'))
      .value;
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_ChapterReadedStoreBase.hasError'))
          .value;

  final _$chapterIdAtom = Atom(name: '_ChapterReadedStoreBase.chapterId');

  @override
  int get chapterId {
    _$chapterIdAtom.reportRead();
    return super.chapterId;
  }

  @override
  set chapterId(int value) {
    _$chapterIdAtom.reportWrite(value, super.chapterId, () {
      super.chapterId = value;
    });
  }

  final _$readedAtom = Atom(name: '_ChapterReadedStoreBase.readed');

  @override
  bool get readed {
    _$readedAtom.reportRead();
    return super.readed;
  }

  @override
  set readed(bool value) {
    _$readedAtom.reportWrite(value, super.readed, () {
      super.readed = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ChapterReadedStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$errorAtom = Atom(name: '_ChapterReadedStoreBase.error');

  @override
  Object get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(Object value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$toggleReadedAsyncAction =
      AsyncAction('_ChapterReadedStoreBase.toggleReaded');

  @override
  Future<void> toggleReaded() {
    return _$toggleReadedAsyncAction.run(() => super.toggleReaded());
  }

  @override
  String toString() {
    return '''
chapterId: ${chapterId},
readed: ${readed},
loading: ${loading},
error: ${error},
loaded: ${loaded},
hasError: ${hasError}
    ''';
  }
}
