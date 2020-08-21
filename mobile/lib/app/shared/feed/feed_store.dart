import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/auth/auth.service.dart';
import 'package:leitor_manga/app/shared/feed/favorite_manga.dto.dart';
import 'package:leitor_manga/app/shared/feed/feed.service.dart';
import 'package:mobx/mobx.dart';

part 'feed_store.g.dart';

class FeedStore = _FeedStoreBase with _$FeedStore;

abstract class _FeedStoreBase with Store {
  final authService = Modular.get<AuthService>();
  final feedService = Modular.get<FeedService>();

  _FeedStoreBase() {
    load();
  }

  @observable
  bool loading = false;

  @observable
  List<FavoriteMangaDto> news = [];

  @observable
  List<FavoriteMangaDto> unread = [];

  @observable
  List<FavoriteMangaDto> others = [];

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
  Future<void> load() async {
    loading = true;
    error = null;

    if (await authService.isSignedIn()) {
      try {
        var favoriteMangas = await feedService.getFavoriteMangas();
        news = <FavoriteMangaDto>[];
        unread = <FavoriteMangaDto>[];
        others = <FavoriteMangaDto>[];

        favoriteMangas.forEach((favoriteManga) {
          if (favoriteManga.neverReaded) {
            unread.add(favoriteManga);
          } else if (favoriteManga.nextChapterId != null) {
            news.add(favoriteManga);
          } else {
            others.add(favoriteManga);
          }
        });
      } catch (error) {
        this.error = error;
      }
    }

    loading = false;
  }
}
