import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/user/user.service.dart';
import 'package:meta/meta.dart';

part 'manga_favorite_event.dart';
part 'manga_favorite_state.dart';

class MangaFavoriteBloc extends Bloc<MangaFavoriteEvent, MangaFavoriteState> {
  static final getIt = GetIt.instance;
  final int mangaId;

  MangaFavoriteBloc(this.mangaId);

  final UserService userService = getIt<UserService>();
  final MangaService mangaService = getIt<MangaService>();

  @override
  MangaFavoriteState get initialState => MangaFavoriteLoading();

  @override
  Stream<MangaFavoriteState> mapEventToState(
    MangaFavoriteEvent event,
  ) async* {
    yield MangaFavoriteLoading();

    if (event is ChangeMangaFavoriteEvent) {
      try {
        yield MangaFavoriteLoaded(
            await mangaService.setMangaFavorite(mangaId, event.favorite));
      } catch (_) {
        yield ChangeMangaFavoriteError(!event.favorite);
      }
    } else if (event is MangaFavoriteLoadedEvent) {
      yield MangaFavoriteLoaded(event.favorite);
    }
  }
}
