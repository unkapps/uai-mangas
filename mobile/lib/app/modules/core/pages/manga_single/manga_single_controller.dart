import 'package:flutter/foundation.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_favorite/manga_favorite_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_single_model.dart';
import 'package:leitor_manga/app/modules/core/shared/manga.service.dart';
import 'package:mobx/mobx.dart';

part 'manga_single_controller.g.dart';

class MangaSingleController = _MangaSingleControllerBase
    with _$MangaSingleController;

abstract class _MangaSingleControllerBase with Store {
  final MangaService mangaService;
  final MangaFavoriteStore mangaFavoriteStore;

  _MangaSingleControllerBase(
      {@required this.mangaService, @required this.mangaFavoriteStore});

  @observable
  ObservableFuture<MangaSingleModel> manga;

  @computed
  String get pageTitle {
    if (manga.status == FutureStatus.rejected) {
      return 'Erro ao carregar :(';
    }

    if (manga.status == FutureStatus.pending) {
      return 'Carregando...';
    }

    return manga.value.name;
  }

  @action
  Future<void> loadManga(mangaId) async {
    this.manga = mangaService.getManga(mangaId).asObservable();
    var manga = await this.manga;

    mangaFavoriteStore.init(mangaId, manga.favorite);
  }
}
