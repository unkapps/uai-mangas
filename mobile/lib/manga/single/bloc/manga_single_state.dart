part of 'manga_single_bloc.dart';

@immutable
abstract class MangaSingleState {}

class MangaSingleLoading extends MangaSingleState {
  @override
  String toString() => 'MangaSingle';
}

class MangaSingleError extends MangaSingleState {
  @override
  String toString() => 'MangaSingleError';
}

class MangaSingle404 extends MangaSingleState {
  @override
  String toString() => 'MangaSingle404';
}

class MangaSingleLoaded extends MangaSingleState {
  final MangaDto manga;

  MangaSingleLoaded(this.manga);

  @override
  String toString() => 'MangaSingleLoaded';
}