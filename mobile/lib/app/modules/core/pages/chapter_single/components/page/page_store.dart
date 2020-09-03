import 'package:mobx/mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_model.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/vertical/page_vertical_listview_controller.dart';

part 'page_store.g.dart';

class PageStore = _PageStoreBase with _$PageStore;

const double opacityChapterBar = 0.8;

abstract class _PageStoreBase with Store {
  final PageVerticalListviewController pageVerticalListviewController;

  final PageModel page;

  //TODO : Use this for vertical_list too
  final bool adPage;

  @observable
  PageLoadStatus status;

  _PageStoreBase(
    bool askForLoad, {
    this.page,
    this.pageVerticalListviewController,
    this.adPage,
  }) : status =
            askForLoad ? PageLoadStatus.IN_PROGRESS : PageLoadStatus.NOT_LOADED;

  @action
  void setStatus(PageLoadStatus status, {int index}) {
    if (status.index != this.status.index) {
      this.status = status;

      if (index != null &&
          status == PageLoadStatus.LOADED &&
          pageVerticalListviewController != null) {
        pageVerticalListviewController.informHeightAndInxOfPage(index);
      }
    }
  }
}

enum PageLoadStatus {
  LOADED,
  NOT_LOADED,
  IN_PROGRESS,
}
