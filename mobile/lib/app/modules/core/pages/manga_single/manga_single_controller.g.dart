// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_single_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MangaSingleController on _MangaSingleControllerBase, Store {
  Computed<String> _$pageTitleComputed;

  @override
  String get pageTitle =>
      (_$pageTitleComputed ??= Computed<String>(() => super.pageTitle,
              name: '_MangaSingleControllerBase.pageTitle'))
          .value;

  final _$mangaAtom = Atom(name: '_MangaSingleControllerBase.manga');

  @override
  ObservableFuture<MangaSingleModel> get manga {
    _$mangaAtom.reportRead();
    return super.manga;
  }

  @override
  set manga(ObservableFuture<MangaSingleModel> value) {
    _$mangaAtom.reportWrite(value, super.manga, () {
      super.manga = value;
    });
  }

  final _$loadMangaAsyncAction =
      AsyncAction('_MangaSingleControllerBase.loadManga');

  @override
  Future<void> loadManga(dynamic mangaId) {
    return _$loadMangaAsyncAction.run(() => super.loadManga(mangaId));
  }

  @override
  String toString() {
    return '''
manga: ${manga},
pageTitle: ${pageTitle}
    ''';
  }
}
