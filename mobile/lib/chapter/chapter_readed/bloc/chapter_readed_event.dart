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

  ChangeChapterReadedEvent(this.readed);

  @override
  String toString() => 'ChangeChapterReadedEvent';
}
