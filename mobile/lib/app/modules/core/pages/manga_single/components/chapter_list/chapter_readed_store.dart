import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/shared/chapter.service.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';
import 'package:mobx/mobx.dart';
import 'package:pedantic/pedantic.dart';

part 'chapter_readed_store.g.dart';

class ChapterReadedStore = _ChapterReadedStoreBase with _$ChapterReadedStore;

abstract class _ChapterReadedStoreBase with Store {
  final chapterService = Modular.get<ChapterService>();
  final feedStore = Modular.get<FeedStore>();

  _ChapterReadedStoreBase(this.chapterId, this.readed);

  @observable
  int chapterId;

  @observable
  bool readed;

  @observable
  bool loading = false;

  @observable
  Object error;

  @computed
  bool get loaded {
    return !loading;
  }

  @computed
  bool get hasError {
    return error != null;
  }

  @action
  Future<void> toggleReaded() async {
    error = null;
    loading = true;

    try {
      readed = await chapterService.setChapterReaded(chapterId, !readed);
      unawaited(feedStore.load());
    } catch (error) {
      this.error = error;
    }

    loading = false;
  }
}
