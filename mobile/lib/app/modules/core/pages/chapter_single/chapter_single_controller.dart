import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/shared/chapter.service.dart';
import 'package:mobx/mobx.dart';

part 'chapter_single_controller.g.dart';

class ChapterSingleController = _ChapterSingleControllerBase
    with _$ChapterSingleController;

const double opacityChapterBar = 0.8;

abstract class _ChapterSingleControllerBase with Store {
  final chapterService = Modular.get<ChapterService>();
  final pageVerticalListviewController = Modular.get<PageVerticalListviewController>();

  @observable
  ObservableFuture<ChapterSingleModel> chapter;

  @observable
  bool showBar = true;

  @observable
  bool chapterReaded;

  @computed
  int get currentPage {
    return pageVerticalListviewController.currentPage;
  }

  @action
  void nextPage() {}

  @action
  void previousPage() {}

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
  void markChapterAsReaded() {
    if (!chapterReaded) {
      chapterReaded = true;
    }
  }

  @action
  void informHeightAndInxOfPage(int index) {
    pageVerticalListviewController.informHeightAndInxOfPage(index);
  }



  @action
  Future<void> goToPage(int pageNumber, bool showDialog) async {}
}
