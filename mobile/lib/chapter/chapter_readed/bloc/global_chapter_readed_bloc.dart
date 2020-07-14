import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'global_chapter_readed_event.dart';
part 'global_chapter_readed_state.dart';

class GlobalChapterReadedBloc
    extends Bloc<GlobalChapterReadedEvent, GlobalChapterReadedState> {
  GlobalChapterReadedBloc() : super(GlobalChapterReadedInitial());

  @override
  Stream<GlobalChapterReadedState> mapEventToState(
    GlobalChapterReadedEvent event,
  ) async* {
    if (event is GlobalChangeChapterReadedEvent) {
      yield GlobalChapterReadedChanged(event.chapterId, event.page,
          isLast: event.isLast);
    }
  }
}
