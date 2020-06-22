part of 'manga_favorite_bloc.dart';

@immutable
abstract class MangaFavoriteState {}

class MangaFavoriteLoading extends MangaFavoriteState {
  @override
  String toString() => 'MangaFavoriteLoading';
}

class ChangeMangaFavorite extends MangaFavoriteState {
  @override
  String toString() => 'ChangeMangaFavorite';
}

class ChangeMangaFavoriteError extends MangaFavoriteState {
  final bool oldFavorited;

  ChangeMangaFavoriteError(bool oldFavorited)
      : oldFavorited = oldFavorited ?? false;

  @override
  String toString() => 'ChangeMangaFavoriteError';
}

class MangaFavoriteLoaded extends MangaFavoriteState {
  final bool favorited;

  MangaFavoriteLoaded(bool favorited) : favorited = favorited ?? false;

  @override
  String toString() => 'MangaFavoriteLoaded';
}
