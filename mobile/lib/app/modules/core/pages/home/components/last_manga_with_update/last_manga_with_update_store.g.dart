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
  Computed<bool> _$hasErrorOnGetMoreItemsComputed;

  @override
  bool get hasErrorOnGetMoreItems => (_$hasErrorOnGetMoreItemsComputed ??=
          Computed<bool>(() => super.hasErrorOnGetMoreItems,
              name: '_LastMangaWithUpdateStoreBase.hasErrorOnGetMoreItems'))
      .value;

  final _$itemsAtom = Atom(name: '_LastMangaWithUpdateStoreBase.items');

  @override
  ObservableList<MangaListViewModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<MangaListViewModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
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

  final _$errorOnGetMoreItemsAtom =
      Atom(name: '_LastMangaWithUpdateStoreBase.errorOnGetMoreItems');

  @override
  Object get errorOnGetMoreItems {
    _$errorOnGetMoreItemsAtom.reportRead();
    return super.errorOnGetMoreItems;
  }

  @override
  set errorOnGetMoreItems(Object value) {
    _$errorOnGetMoreItemsAtom.reportWrite(value, super.errorOnGetMoreItems, () {
      super.errorOnGetMoreItems = value;
    });
  }

  final _$loadingMoreItemsAtom =
      Atom(name: '_LastMangaWithUpdateStoreBase.loadingMoreItems');

  @override
  bool get loadingMoreItems {
    _$loadingMoreItemsAtom.reportRead();
    return super.loadingMoreItems;
  }

  @override
  set loadingMoreItems(bool value) {
    _$loadingMoreItemsAtom.reportWrite(value, super.loadingMoreItems, () {
      super.loadingMoreItems = value;
    });
  }

  final _$loadItemsAsyncAction =
      AsyncAction('_LastMangaWithUpdateStoreBase.loadItems');

  @override
  Future<void> loadItems() {
    return _$loadItemsAsyncAction.run(() => super.loadItems());
  }

  final _$loadMoreItemsAsyncAction =
      AsyncAction('_LastMangaWithUpdateStoreBase.loadMoreItems');

  @override
  Future<void> loadMoreItems() {
    return _$loadMoreItemsAsyncAction.run(() => super.loadMoreItems());
  }

  @override
  String toString() {
    return '''
items: ${items},
error: ${error},
loading: ${loading},
errorOnGetMoreItems: ${errorOnGetMoreItems},
loadingMoreItems: ${loadingMoreItems},
hasError: ${hasError},
hasErrorOnGetMoreItems: ${hasErrorOnGetMoreItems}
    ''';
  }
}
