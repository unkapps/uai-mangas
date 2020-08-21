// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeedStore on _FeedStoreBase, Store {
  Computed<bool> _$loadedComputed;

  @override
  bool get loaded => (_$loadedComputed ??=
          Computed<bool>(() => super.loaded, name: '_FeedStoreBase.loaded'))
      .value;
  Computed<bool> _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??=
          Computed<bool>(() => super.hasError, name: '_FeedStoreBase.hasError'))
      .value;

  final _$loadingAtom = Atom(name: '_FeedStoreBase.loading');

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

  final _$newsAtom = Atom(name: '_FeedStoreBase.news');

  @override
  List<FavoriteMangaDto> get news {
    _$newsAtom.reportRead();
    return super.news;
  }

  @override
  set news(List<FavoriteMangaDto> value) {
    _$newsAtom.reportWrite(value, super.news, () {
      super.news = value;
    });
  }

  final _$unreadAtom = Atom(name: '_FeedStoreBase.unread');

  @override
  List<FavoriteMangaDto> get unread {
    _$unreadAtom.reportRead();
    return super.unread;
  }

  @override
  set unread(List<FavoriteMangaDto> value) {
    _$unreadAtom.reportWrite(value, super.unread, () {
      super.unread = value;
    });
  }

  final _$othersAtom = Atom(name: '_FeedStoreBase.others');

  @override
  List<FavoriteMangaDto> get others {
    _$othersAtom.reportRead();
    return super.others;
  }

  @override
  set others(List<FavoriteMangaDto> value) {
    _$othersAtom.reportWrite(value, super.others, () {
      super.others = value;
    });
  }

  final _$errorAtom = Atom(name: '_FeedStoreBase.error');

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

  final _$loadAsyncAction = AsyncAction('_FeedStoreBase.load');

  @override
  Future<void> load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
loading: ${loading},
news: ${news},
unread: ${unread},
others: ${others},
error: ${error},
loaded: ${loaded},
hasError: ${hasError}
    ''';
  }
}
