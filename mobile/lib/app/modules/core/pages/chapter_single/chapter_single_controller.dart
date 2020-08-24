import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_readed_store.dart';
import 'package:leitor_manga/app/modules/core/shared/chapter.service.dart';
import 'package:mobx/mobx.dart';

part 'chapter_single_controller.g.dart';

class ChapterSingleController = _ChapterSingleControllerBase
    with _$ChapterSingleController;

const double opacityChapterBar = 0.8;

abstract class _ChapterSingleControllerBase extends Disposable with Store {
  final chapterService = Modular.get<ChapterService>();
  final chapterListReadedStore = Modular.get<ChapterListReadedStore>();

  final pageVerticalListviewController =
      Modular.get<PageVerticalListviewController>();

  ReactionDisposer reactionDisposer;

  @observable
  ObservableFuture<ChapterSingleModel> chapter;

  @observable
  bool chapterReaded;

  @computed
  int get currentPage {
    return pageVerticalListviewController.currentPage;
  }

  @computed
  bool get showBar {
    return pageVerticalListviewController.showBar;
  }

  _ChapterSingleControllerBase() {
    reactionDisposer = autorun((_) {
      if (chapter.status == FutureStatus.fulfilled &&
          currentPage + 1 == chapter.value.pages.length) {
        markChapterAsReaded();
      }
    });
  }

  @override
  void dispose() {
    reactionDisposer();
  }

  @action
  void nextPage() {
    pageVerticalListviewController.nextPage();
  }

  @action
  void previousPage() {
    pageVerticalListviewController.previousPage();
  }

  @computed
  String get pageTitle {
    if (chapter.status == FutureStatus.rejected) {
      return 'Erro ao carregar :(';
    }

    if (chapter.status == FutureStatus.pending) {
      return 'Carregando...';
    }

    return chapter.value.title;
  }

  @computed
  double get barOpacity {
    return showBar ? opacityChapterBar : 0;
  }

  @action
  Future<void> loadChapter(int chapterId) async {
    this.chapter = chapterService.getChapter(chapterId).asObservable();

    var chapter = await this.chapter;

    pageVerticalListviewController.init(chapter);

    chapterReaded = chapter.readed;
  }

  @action
  Future<void> markChapterAsReaded() async {
    if (chapter.status == FutureStatus.fulfilled && !chapterReaded) {
      var chapterReadedStore =
          chapterListReadedStore.chapterStoreById[chapter.value.id];

      chapterReaded = await chapterReadedStore.setReaded(true);
    }
  }

  @action
  void informHeightAndInxOfPage(int index) {
    pageVerticalListviewController.informHeightAndInxOfPage(index);
  }

  @action
  Future<void> goToPage(int pageNumber, bool showDialog) async {
    await pageVerticalListviewController.goToPage(pageNumber, showDialog);
  }

  @action
  void didChangeMetrics() {
    pageVerticalListviewController.recalculateHeightOfPages();

    pageVerticalListviewController.rebuildChaptersMap();
    pageVerticalListviewController.goToPage(
        pageVerticalListviewController.currentPage, false);
  }
}
