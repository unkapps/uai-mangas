// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PageStore on _PageStoreBase, Store {
  final _$statusAtom = Atom(name: '_PageStoreBase.status');

  @override
  PageLoadStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(PageLoadStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_PageStoreBaseActionController =
      ActionController(name: '_PageStoreBase');

  @override
  void setStatus(PageLoadStatus status, {int index}) {
    final _$actionInfo = _$_PageStoreBaseActionController.startAction(
        name: '_PageStoreBase.setStatus');
    try {
      return super.setStatus(status, index: index);
    } finally {
      _$_PageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
