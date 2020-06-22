part of 'manga_single_bloc.dart';

@immutable
abstract class MangaSingleEvent {}

class LoadMangaSingleEvent extends MangaSingleEvent {
  LoadMangaSingleEvent();

  @override
  String toString() => 'LoadMangaSingleEvent';
}
