part of 'global_chapter_readed_bloc.dart';

@immutable
abstract class GlobalChapterReadedState {}

class GlobalChapterReadedInitial extends GlobalChapterReadedState {}

class GlobalChapterReadedChanged extends GlobalChapterReadedState {
  final int chapterId;
  final int page;
  final bool isLast;

  GlobalChapterReadedChanged(this.chapterId, this.page,
      {bool isLast})
      : isLast = isLast ?? false;

  @override
  String toString() => 'GlobalChapterReadedInitial';
}
