// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$VersionStore on _VersionStoreBase, Store {
  Computed<bool> _$versionLoadedComputed;

  @override
  bool get versionLoaded =>
      (_$versionLoadedComputed ??= Computed<bool>(() => super.versionLoaded,
              name: '_VersionStoreBase.versionLoaded'))
          .value;

  final _$versionAtom = Atom(name: '_VersionStoreBase.version');

  @override
  String get version {
    _$versionAtom.reportRead();
    return super.version;
  }

  @override
  set version(String value) {
    _$versionAtom.reportWrite(value, super.version, () {
      super.version = value;
    });
  }

  final _$versionCodeAtom = Atom(name: '_VersionStoreBase.versionCode');

  @override
  int get versionCode {
    _$versionCodeAtom.reportRead();
    return super.versionCode;
  }

  @override
  set versionCode(int value) {
    _$versionCodeAtom.reportWrite(value, super.versionCode, () {
      super.versionCode = value;
    });
  }

  final _$getVersionAsyncAction = AsyncAction('_VersionStoreBase.getVersion');

  @override
  Future<void> getVersion() {
    return _$getVersionAsyncAction.run(() => super.getVersion());
  }

  @override
  String toString() {
    return '''
version: ${version},
versionCode: ${versionCode},
versionLoaded: ${versionLoaded}
    ''';
  }
}
