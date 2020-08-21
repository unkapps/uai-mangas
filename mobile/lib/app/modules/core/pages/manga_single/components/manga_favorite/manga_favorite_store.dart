import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/shared/manga.service.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';
import 'package:mobx/mobx.dart';
import 'package:pedantic/pedantic.dart';

part 'manga_favorite_store.g.dart';

class MangaFavoriteStore = _MangaFavoriteStoreBase with _$MangaFavoriteStore;

abstract class _MangaFavoriteStoreBase with Store {
  final MangaService mangaService;
  final feedStore = Modular.get<FeedStore>();

  _MangaFavoriteStoreBase({@required this.mangaService});

  @observable
  int mangaId;

  @observable
  bool favorite;

  @observable
  bool loading;

  @observable
  Object error;

  @computed
  bool get loaded {
    return !loading;
  }

  @computed
  bool get hasError {
    return error != null;
  }

  @action
  void init(int mangaId, bool initialFavorite) {
    this.mangaId = mangaId;
    favorite = initialFavorite;
    error = null;
    loading = false;
  }

  @action
  Future<void> toggleFavorite() async {
    error = null;
    loading = true;

    try {
      favorite = await mangaService.setMangaFavorite(mangaId, !favorite);
      unawaited(feedStore.load());
    } catch (error) {
      this.error = error;
    }

    loading = false;
  }
}
