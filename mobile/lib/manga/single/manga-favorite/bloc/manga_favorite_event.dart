part of 'manga_favorite_bloc.dart';

@immutable
abstract class MangaFavoriteEvent {}

class MangaFavoriteLoadedEvent extends MangaFavoriteEvent {
  final bool favorite;

  MangaFavoriteLoadedEvent(this.favorite);

  @override
  String toString() => 'MangaFavoriteLoadedEvent';
}

class ChangeMangaFavoriteEvent extends MangaFavoriteEvent {
  final bool favorite;

  ChangeMangaFavoriteEvent(this.favorite);

  @override
  String toString() => 'ChangeMangaFavoriteEvent';
}
