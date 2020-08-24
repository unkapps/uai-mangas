// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_single_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategorySingleController on _CategorySingleControllerBase, Store {
  final _$categoryAtom = Atom(name: '_CategorySingleControllerBase.category');

  @override
  ObservableFuture<CategorySingleModel> get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(ObservableFuture<CategorySingleModel> value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  final _$_CategorySingleControllerBaseActionController =
      ActionController(name: '_CategorySingleControllerBase');

  @override
  void load(int categoryId) {
    final _$actionInfo = _$_CategorySingleControllerBaseActionController
        .startAction(name: '_CategorySingleControllerBase.load');
    try {
      return super.load(categoryId);
    } finally {
      _$_CategorySingleControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
category: ${category}
    ''';
  }
}
