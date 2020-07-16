part of 'chapter_readed_bloc.dart';

@immutable
abstract class ChapterReadedState {}

class ChapterReadedLoading extends ChapterReadedState {
  @override
  String toString() => 'ChapterReadedLoading';
}

class ChangeChapterReaded extends ChapterReadedState {
  @override
  String toString() => 'ChangeChapterReaded';
}

class ChangeChapterReadedError extends ChapterReadedState {
  final bool oldReaded;

  ChangeChapterReadedError(bool oldReaded) : oldReaded = oldReaded ?? false;

  @override
  String toString() => 'ChangeChapterReadedError';
}

class ChapterReadedLoaded extends ChapterReadedState {
  final bool readed;
  final bool savedOnThisBloc;

  ChapterReadedLoaded(bool readed, {this.savedOnThisBloc})
      : readed = readed ?? false;

  @override
  String toString() => 'ChapterReadedLoaded';
}

class ChapterReadedLoadedFromLocal extends ChapterReadedState {
  final bool readed;

  ChapterReadedLoadedFromLocal(bool readed) : readed = readed ?? false;

  @override
  String toString() => 'ChapterReadedLoadedFromLocal';
}
