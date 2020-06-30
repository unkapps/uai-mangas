part of 'feed_bloc.dart';

@immutable
abstract class FeedState {}

class FeedUninitialized extends FeedState {}

class FeedLoading extends FeedState {
  @override
  String toString() => 'FeedLoading';
}

class FeedError extends FeedState {
  @override
  String toString() => 'FeedError';
}

class FeedUnauthenticated extends FeedState {
  @override
  String toString() => 'FeedUnauthenticated';
}

class FeedLoaded extends FeedState {
  final List<FavoriteMangaDto> news;
  final List<FavoriteMangaDto> unread;
  final List<FavoriteMangaDto> others;

  FeedLoaded(
      {@required this.news, @required this.unread, @required this.others});

  @override
  String toString() => 'FeedLoaded';
}
