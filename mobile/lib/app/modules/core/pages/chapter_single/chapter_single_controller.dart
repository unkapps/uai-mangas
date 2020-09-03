import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_readed_store.dart';
import 'package:leitor_manga/app/modules/core/shared/chapter.service.dart';
import 'package:mobx/mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_listview_controller_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'chapter_single_controller.g.dart';

class ChapterSingleController = _ChapterSingleControllerBase
    with _$ChapterSingleController;

const double opacityChapterBar = 0.8;
const String reading_mode_key = 'reading_mode';

abstract class _ChapterSingleControllerBase extends Disposable with Store {
  final chapterService = Modular.get<ChapterService>();
  final chapterListReadedStore = Modular.get<ChapterListReadedStore>();
  SharedPreferences sharedPreferences;

  @observable
  IPageListViewController pageListViewController;

  ReactionDisposer reactionDisposer;

  @observable
  ObservableFuture<ChapterSingleModel> chapter;

  @observable
  bool chapterReaded;

  @observable
  ReadingMode readingMode = ReadingMode.VERTICAL;

  @computed
  int get currentPage {
    return pageListViewController.currentPage;
  }

  @computed
  int get totalPages {
    return pageListViewController.totalPages;
  }

  @computed
  bool get showBar {
    return pageListViewController.showBar;
  }

  _ChapterSingleControllerBase() {
    reactionDisposer = autorun((_) {
      if (chapter != null &&
          chapter.status == FutureStatus.fulfilled &&
          currentPage + 1 == totalPages) {
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
    pageListViewController.nextPage();
  }

  @action
  void previousPage() {
    pageListViewController.previousPage();
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
    chapter = chapterService.getChapter(chapterId).asObservable();

    await initChapter();
  }

  @action
  Future<void> initChapter() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey(reading_mode_key)) {
      setReadingMode(
          ReadingMode.values[sharedPreferences.getInt(reading_mode_key)],
          saveOnShared: false);
    }

    var chapter = await this.chapter;

    pageListViewController =
        PageListViewUtils.getListViewControllerInstance(readingMode, chapter);

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
  Future<void> goToPage(int pageNumber, bool showDialog) async {
    await pageListViewController.goToPage(pageNumber, showDialog);
  }

  @action
  void didChangeMetrics() {
    if (pageListViewController is PageVerticalListviewController) {
      final pageVerticalListviewController =
          pageListViewController as PageVerticalListviewController;
      pageVerticalListviewController.recalculateHeightOfPages();

      pageVerticalListviewController.rebuildChaptersMap();

      pageListViewController.goToPage(
          pageListViewController.currentPage, false);
    }
  }

  @action
  void toggleReadingMode() {
    final newReadingMode = readingMode == ReadingMode.HORIZONTAL
        ? ReadingMode.VERTICAL
        : ReadingMode.HORIZONTAL;

    setReadingMode(newReadingMode, saveOnShared: true);

    initChapter();
  }

  @action
  void setReadingMode(ReadingMode readingMode, {saveOnShared = true}) {
    this.readingMode = readingMode;

    if (saveOnShared) {
      sharedPreferences.setInt(reading_mode_key, readingMode.index);
    }
  }
}

enum ReadingMode { VERTICAL, HORIZONTAL }

extension ReadingModeExtensionName on ReadingMode {
  String get name {
    switch (this) {
      case ReadingMode.HORIZONTAL:
        return 'Alterar para modo vertical';
      case ReadingMode.VERTICAL:
        return 'Alterar para modo horizontal';
      default:
        return null;
    }
  }

  String get assetUrl {
    switch (this) {
      case ReadingMode.HORIZONTAL:
        return 'assets/images/horizontal_navigation.png';
      case ReadingMode.VERTICAL:
        return 'assets/images/vertical_navigation.png';
      default:
        return null;
    }
  }
}
