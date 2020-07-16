part of 'global_chapter_readed_bloc.dart';

@immutable
abstract class GlobalChapterReadedState {}

class GlobalChapterReadedInitial extends GlobalChapterReadedState {}

class GlobalChapterReadedChanged extends GlobalChapterReadedState {
  final int chapterId;
  final bool readed;
  final bool savedOnThisBloc;

  GlobalChapterReadedChanged(this.chapterId, this.readed, this.savedOnThisBloc);

  @override
  String toString() => 'GlobalChapterReadedInitial';
}
class GlobalChapterReadedFromLocal extends GlobalChapterReadedState {
  final int chapterId;
  final bool readed;

  GlobalChapterReadedFromLocal(this.chapterId, this.readed);

  @override
  String toString() => 'GlobalChapterReadedFromLocal';
}
