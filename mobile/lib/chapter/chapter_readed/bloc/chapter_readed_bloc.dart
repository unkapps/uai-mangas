import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:meta/meta.dart';

part 'chapter_readed_event.dart';
part 'chapter_readed_state.dart';

class ChapterReadedBloc extends Bloc<ChapterReadedEvent, ChapterReadedState> {
  static final getIt = GetIt.instance;
  final int chapterId;

  ChapterReadedBloc(this.chapterId) : super(ChapterReadedLoading());

  final ChapterService chapterService = getIt<ChapterService>();

  @override
  Stream<ChapterReadedState> mapEventToState(
    ChapterReadedEvent event,
  ) async* {
    yield ChapterReadedLoading();

    if (event is ChangeChapterReadedEvent) {
      if (event.alreadySaved) {
        yield ChapterReadedLoaded(event.readed, savedOnThisBloc: false);
      } else {
        try {
          yield ChapterReadedLoaded(
            await chapterService.setChapterReaded(chapterId, event.readed),
            savedOnThisBloc: true,
          );
        } catch (_) {
          yield ChangeChapterReadedError(!event.readed);
        }
      }
    } else if (event is ChapterReadedLoadedEvent) {
      yield ChapterReadedLoaded(event.readed);
    } else if(event is ChangeChapterReadedEventFromLocal) {
      yield ChapterReadedLoadedFromLocal(event.readed);
    }
  }
}
