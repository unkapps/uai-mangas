part of 'chapter_readed_bloc.dart';

@immutable
abstract class ChapterReadedEvent {}

class ChapterReadedLoadedEvent extends ChapterReadedEvent {
  final bool readed;

  ChapterReadedLoadedEvent(this.readed);

  @override
  String toString() => 'ChapterReadedLoadedEvent';
}

class ChangeChapterReadedEvent extends ChapterReadedEvent {
  final bool readed;
  final bool alreadySaved;

  ChangeChapterReadedEvent(this.readed, this.alreadySaved);

  @override
  String toString() => 'ChangeChapterReadedEvent';
}
class ChangeChapterReadedEventFromLocal extends ChapterReadedEvent {
  final bool readed;

  ChangeChapterReadedEventFromLocal(this.readed);

  @override
  String toString() => 'ChangeChapterReadedEventFromLocal';
}
