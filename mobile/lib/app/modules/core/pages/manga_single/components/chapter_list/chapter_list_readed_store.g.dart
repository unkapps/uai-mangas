// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter_list_readed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChapterListReadedStore on _ChapterListReadedStoreBase, Store {
  final _$chapterStoreByIdAtom =
      Atom(name: '_ChapterListReadedStoreBase.chapterStoreById');

  @override
  ObservableMap<int, ChapterReadedStore> get chapterStoreById {
    _$chapterStoreByIdAtom.reportRead();
    return super.chapterStoreById;
  }

  @override
  set chapterStoreById(ObservableMap<int, ChapterReadedStore> value) {
    _$chapterStoreByIdAtom.reportWrite(value, super.chapterStoreById, () {
      super.chapterStoreById = value;
    });
  }

  final _$_ChapterListReadedStoreBaseActionController =
      ActionController(name: '_ChapterListReadedStoreBase');

  @override
  void init() {
    final _$actionInfo = _$_ChapterListReadedStoreBaseActionController
        .startAction(name: '_ChapterListReadedStoreBase.init');
    try {
      return super.init();
    } finally {
      _$_ChapterListReadedStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chapterStoreById: ${chapterStoreById}
    ''';
  }
}
