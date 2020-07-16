part of 'global_chapter_readed_bloc.dart';

@immutable
abstract class GlobalChapterReadedEvent {}

class GlobalChangeChapterReadedEvent extends GlobalChapterReadedEvent {
  final int chapterId;
  final bool readed;

  GlobalChangeChapterReadedEvent(this.chapterId, this.readed);

  @override
  String toString() => 'GlobalChangeChapterReadedEvent';
}

class GlobalChangeChapterReadedEventFromLocal extends GlobalChapterReadedEvent {
  final int chapterId;
  final bool readed;

  GlobalChangeChapterReadedEventFromLocal(this.chapterId, this.readed);

  @override
  String toString() => 'GlobalChangeChapterReadedEventFromLocal';
}
