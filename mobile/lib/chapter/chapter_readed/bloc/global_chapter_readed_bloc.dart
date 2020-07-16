import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/chapter/chapter.service.dart';
import 'package:meta/meta.dart';

part 'global_chapter_readed_event.dart';
part 'global_chapter_readed_state.dart';

class GlobalChapterReadedBloc
    extends Bloc<GlobalChapterReadedEvent, GlobalChapterReadedState> {
  static final getIt = GetIt.instance;
  final ChapterService chapterService = getIt<ChapterService>();

  GlobalChapterReadedBloc() : super(GlobalChapterReadedInitial());

  @override
  Stream<GlobalChapterReadedState> mapEventToState(
    GlobalChapterReadedEvent event,
  ) async* {
    if (event is GlobalChangeChapterReadedEvent) {
      yield GlobalChapterReadedChanged(
        event.chapterId,
        await chapterService.setChapterReaded(event.chapterId, event.readed),
        true,
      );
    } else if (event is GlobalChangeChapterReadedEventFromLocal) {
      yield GlobalChapterReadedFromLocal(event.chapterId, event.readed);
    }
  }
}
