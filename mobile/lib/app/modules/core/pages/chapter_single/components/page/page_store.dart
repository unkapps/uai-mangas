import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_model.dart';
import 'package:mobx/mobx.dart';

part 'page_store.g.dart';

class PageStore = _PageStoreBase with _$PageStore;

const double opacityChapterBar = 0.8;

abstract class _PageStoreBase with Store {
  final chapterSingleController = Modular.get<ChapterSingleController>();

  final PageModel page;

  @observable
  PageLoadStatus status;

  _PageStoreBase(this.page, bool askForLoad)
      : status =
            askForLoad ? PageLoadStatus.IN_PROGRESS : PageLoadStatus.NOT_LOADED;

  @action
  void setStatus(PageLoadStatus status, {int index}) {
    if (status.index != this.status.index) {
      this.status = status;

      if (index != null && status == PageLoadStatus.LOADED) {
        chapterSingleController.informHeightAndInxOfPage(index);
      }
    }
  }
}

enum PageLoadStatus {
  LOADED,
  NOT_LOADED,
  IN_PROGRESS,
}
