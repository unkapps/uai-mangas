// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriesStore on _CategoriesStoreBase, Store {
  final _$categoriesAtom = Atom(name: '_CategoriesStoreBase.categories');

  @override
  ObservableFuture<List<CategoryListModel>> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableFuture<List<CategoryListModel>> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('_CategoriesStoreBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
categories: ${categories}
    ''';
  }
}
