// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_mangas_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AllMangasStore on _AllMangasStoreBase, Store {
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError =>
      (_$hasErrorComputed ??= Computed<bool>(() => super.hasError,
              name: '_AllMangasStoreBase.hasError'))
          .value;
  Computed<bool> _$hasErrorOnGetMoreItemsComputed;

  @override
  bool get hasErrorOnGetMoreItems => (_$hasErrorOnGetMoreItemsComputed ??=
          Computed<bool>(() => super.hasErrorOnGetMoreItems,
              name: '_AllMangasStoreBase.hasErrorOnGetMoreItems'))
      .value;

  final _$itemsAtom = Atom(name: '_AllMangasStoreBase.items');

  @override
  ObservableList<MangaGridViewModel> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<MangaGridViewModel> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$qtyPagesAtom = Atom(name: '_AllMangasStoreBase.qtyPages');

  @override
  int get qtyPages {
    _$qtyPagesAtom.reportRead();
    return super.qtyPages;
  }

  @override
  set qtyPages(int value) {
    _$qtyPagesAtom.reportWrite(value, super.qtyPages, () {
      super.qtyPages = value;
    });
  }

  final _$errorAtom = Atom(name: '_AllMangasStoreBase.error');

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

  final _$loadingAtom = Atom(name: '_AllMangasStoreBase.loading');

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
      Atom(name: '_AllMangasStoreBase.errorOnGetMoreItems');

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
      Atom(name: '_AllMangasStoreBase.loadingMoreItems');

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

  final _$sortingChoiceAtom = Atom(name: '_AllMangasStoreBase.sortingChoice');

  @override
  MangaSortingChoice get sortingChoice {
    _$sortingChoiceAtom.reportRead();
    return super.sortingChoice;
  }

  @override
  set sortingChoice(MangaSortingChoice value) {
    _$sortingChoiceAtom.reportWrite(value, super.sortingChoice, () {
      super.sortingChoice = value;
    });
  }

  final _$loadItemsAsyncAction = AsyncAction('_AllMangasStoreBase.loadItems');

  @override
  Future<void> loadItems() {
    return _$loadItemsAsyncAction.run(() => super.loadItems());
  }

  final _$_AllMangasStoreBaseActionController =
      ActionController(name: '_AllMangasStoreBase');

  @override
  void init(String mangaName) {
    final _$actionInfo = _$_AllMangasStoreBaseActionController.startAction(
        name: '_AllMangasStoreBase.init');
    try {
      return super.init(mangaName);
    } finally {
      _$_AllMangasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSorting(MangaSortingChoice sortingChoice) {
    final _$actionInfo = _$_AllMangasStoreBaseActionController.startAction(
        name: '_AllMangasStoreBase.changeSorting');
    try {
      return super.changeSorting(sortingChoice);
    } finally {
      _$_AllMangasStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
items: ${items},
qtyPages: ${qtyPages},
error: ${error},
loading: ${loading},
errorOnGetMoreItems: ${errorOnGetMoreItems},
loadingMoreItems: ${loadingMoreItems},
sortingChoice: ${sortingChoice},
hasError: ${hasError},
hasErrorOnGetMoreItems: ${hasErrorOnGetMoreItems}
    ''';
  }
}
