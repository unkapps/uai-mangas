// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$searchModeAtom = Atom(name: '_HomeControllerBase.searchMode');

  @override
  bool get searchMode {
    _$searchModeAtom.reportRead();
    return super.searchMode;
  }

  @override
  set searchMode(bool value) {
    _$searchModeAtom.reportWrite(value, super.searchMode, () {
      super.searchMode = value;
    });
  }

  final _$queryAtom = Atom(name: '_HomeControllerBase.query');

  @override
  String get query {
    _$queryAtom.reportRead();
    return super.query;
  }

  @override
  set query(String value) {
    _$queryAtom.reportWrite(value, super.query, () {
      super.query = value;
    });
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setSearchMode(dynamic searchMode) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setSearchMode');
    try {
      return super.setSearchMode(searchMode);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuery(dynamic query) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setQuery');
    try {
      return super.setQuery(query);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchMode: ${searchMode},
query: ${query}
    ''';
  }
}
