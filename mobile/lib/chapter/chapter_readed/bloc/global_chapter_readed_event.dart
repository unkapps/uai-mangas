part of 'global_chapter_readed_bloc.dart';

@immutable
abstract class GlobalChapterReadedEvent {}

class GlobalChangeChapterReadedEvent extends GlobalChapterReadedEvent {
  final int chapterId;
  final int page;
  final bool isLast;

  GlobalChangeChapterReadedEvent(this.chapterId, this.page,
      {bool isLast})
      : isLast = isLast ?? false;

  @override
  String toString() => 'GlobalChangeChapterReadedEvent';
}
