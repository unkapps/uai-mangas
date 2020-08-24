import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/manga_sort.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/sortable_store_interface.dart';
import 'package:leitor_manga/app/modules/core/pages/home/home_controller.dart';
import 'package:leitor_manga/app/modules/core/shared/manga.service.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_gridview/manga_gridview_model.dart';
import 'package:leitor_manga/app/shared/pageable/pageable_store_interface.dart';
import 'package:mobx/mobx.dart';

part 'all_mangas_store.g.dart';

class AllMangasStore = _AllMangasStoreBase with _$AllMangasStore;

abstract class _AllMangasStoreBase
    with Store
    implements IPageableStore<MangaGridViewModel>, ISortableStore {
  final mangaService = Modular.get<MangaService>();
  final HomeController homeController;

  _AllMangasStoreBase({@required this.homeController});

  @observable
  @override
  ObservableList<MangaGridViewModel> items =
      ObservableList<MangaGridViewModel>();

  @observable
  @override
  int qtyPages;

  @observable
  int categoryId;

  @override
  @observable
  Object error;

  @override
  @observable
  bool loading = false;

  @override
  @observable
  Object errorOnGetMoreItems;

  @override
  @observable
  bool loadingMoreItems = false;

  @override
  @observable
  MangaSortingChoice sortingChoice;

  @override
  @computed
  bool get hasError {
    return error != null;
  }

  @override
  @computed
  bool get hasErrorOnGetMoreItems {
    return errorOnGetMoreItems != null;
  }

  @action
  void init(String mangaName, {int categoryId}) {
    sortingChoice = mangaName != null
        ? MangaSortingChoice.RELEVANCE
        : MangaSortingChoice.NAME;

    this.categoryId = categoryId;
  }

  @action
  @override
  Future<void> loadItems() async {
    loading = true;
    error = null;
    loadingMoreItems = false;
    errorOnGetMoreItems = null;

    try {
      var page = await mangaService.getAllManga(
        sortingChoice,
        name: homeController.query,
        categoryId: categoryId,
      );

      qtyPages = page.qtyPages;
      items = page.data.asObservable();
    } catch (err) {
      error = err;
    }

    loading = false;
  }

  @override
  Future<void> loadMoreItems() async {
    loadingMoreItems = true;
    errorOnGetMoreItems = null;

    try {
      items.addAll(
        await mangaService.getAllMangaWithoutCount(
          sortingChoice,
          offset: items.length,
          name: homeController.query,
          categoryId: categoryId,
        ),
      );
    } catch (err) {
      errorOnGetMoreItems = err;
    }

    loadingMoreItems = false;
  }

  @action
  @override
  void changeSorting(MangaSortingChoice sortingChoice) {
    this.sortingChoice = sortingChoice;

    loadItems();
  }
}
