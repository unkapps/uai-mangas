// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_favorite_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MangaFavoriteStore on _MangaFavoriteStoreBase, Store {
  Computed<bool> _$loadedComputed;

  @override
  bool get loaded => (_$loadedComputed ??= Computed<bool>(() => super.loaded,
          name: '_MangaFavoriteStoreBase.loaded'))
      .value;
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_MangaFavoriteStoreBase.hasError'))
          .value;

  final _$mangaIdAtom = Atom(name: '_MangaFavoriteStoreBase.mangaId');

  @override
  int get mangaId {
    _$mangaIdAtom.reportRead();
    return super.mangaId;
  }

  @override
  set mangaId(int value) {
    _$mangaIdAtom.reportWrite(value, super.mangaId, () {
      super.mangaId = value;
    });
  }

  final _$favoriteAtom = Atom(name: '_MangaFavoriteStoreBase.favorite');

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  final _$loadingAtom = Atom(name: '_MangaFavoriteStoreBase.loading');

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

  final _$errorAtom = Atom(name: '_MangaFavoriteStoreBase.error');

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

  final _$toggleFavoriteAsyncAction =
      AsyncAction('_MangaFavoriteStoreBase.toggleFavorite');

  @override
  Future<void> toggleFavorite() {
    return _$toggleFavoriteAsyncAction.run(() => super.toggleFavorite());
  }

  final _$_MangaFavoriteStoreBaseActionController =
      ActionController(name: '_MangaFavoriteStoreBase');

  @override
  void init(int mangaId, bool initialFavorite) {
    final _$actionInfo = _$_MangaFavoriteStoreBaseActionController.startAction(
        name: '_MangaFavoriteStoreBase.init');
    try {
      return super.init(mangaId, initialFavorite);
    } finally {
      _$_MangaFavoriteStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
mangaId: ${mangaId},
favorite: ${favorite},
loading: ${loading},
error: ${error},
loaded: ${loaded},
hasError: ${hasError}
    ''';
  }
}
