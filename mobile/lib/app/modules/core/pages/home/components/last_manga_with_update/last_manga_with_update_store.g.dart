// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_manga_with_update_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LastMangaWithUpdateStore on _LastMangaWithUpdateStoreBase, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_LastMangaWithUpdateStoreBase.hasError'))
          .value;

  final _$mangasAtom = Atom(name: '_LastMangaWithUpdateStoreBase.mangas');

  @override
  ObservableList<MangaListViewModel> get mangas {
    _$mangasAtom.reportRead();
    return super.mangas;
  }

  @override
  set mangas(ObservableList<MangaListViewModel> value) {
    _$mangasAtom.reportWrite(value, super.mangas, () {
      super.mangas = value;
    });
  }

  final _$errorAtom = Atom(name: '_LastMangaWithUpdateStoreBase.error');

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

  final _$loadingAtom = Atom(name: '_LastMangaWithUpdateStoreBase.loading');

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

  final _$loadMangasAsyncAction =
      AsyncAction('_LastMangaWithUpdateStoreBase.loadMangas');

  @override
  Future<void> loadMangas() {
    return _$loadMangasAsyncAction.run(() => super.loadMangas());
  }

  @override
  String toString() {
    return '''
mangas: ${mangas},
error: ${error},
loading: ${loading},
hasError: ${hasError}
    ''';
  }
}
