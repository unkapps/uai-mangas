import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/user/user.service.dart';
import 'package:meta/meta.dart';
import 'package:leitor_manga/feed/favorite_manga.dto.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  static final getIt = GetIt.instance;

  final MangaService mangaService = getIt<MangaService>();
  final UserService userService = getIt<UserService>();

  @override
  FeedState get initialState => FeedUninitialized();

  @override
  Stream<FeedState> mapEventToState(
    FeedEvent event,
  ) async* {
    if (event is LoadFeedEvent) {
      yield FeedLoading();

      if (await userService.getUser() == null) {
        yield FeedUnauthenticated();
      } else {
        try {
          var favoriteMangas = await mangaService.getFavoriteMangas();
          var news = <FavoriteMangaDto>[];
          var unread = <FavoriteMangaDto>[];
          var others = <FavoriteMangaDto>[];

          favoriteMangas.forEach((favoriteManga) {
            if (favoriteManga.neverReaded) {
              unread.add(favoriteManga);
            } else if (favoriteManga.nextChapterId != null) {
              news.add(favoriteManga);
            } else {
              others.add(favoriteManga);
            }
          });

          yield FeedLoaded(news: news, unread: unread, others: others);
        } catch (_) {
          yield FeedError();
        }
      }
    } else {
      yield FeedUnauthenticated();
    }
  }
}
