import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_readed_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/manga_single_controller.dart';
import 'package:mobx/mobx.dart';

part 'chapter_list_readed_store.g.dart';

class ChapterListReadedStore = _ChapterListReadedStoreBase
    with _$ChapterListReadedStore;

abstract class _ChapterListReadedStoreBase extends Disposable with Store {
  final mangaSingleController = Modular.get<MangaSingleController>();
  ReactionDisposer mangaSinglePageDisposer;

  @observable
  ObservableMap<int, ChapterReadedStore> chapterStoreById;

  _ChapterListReadedStoreBase() {
    mangaSinglePageDisposer = when(
        (_) => mangaSingleController.manga.status == FutureStatus.fulfilled,
        () => init());
  }

  @action
  void init() {
    chapterStoreById = ObservableMap<int, ChapterReadedStore>();
  }

  @override
  void dispose() {
    if (mangaSinglePageDisposer != null) {
      mangaSinglePageDisposer();
    }
  }
}
