import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/shared/manga.service.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_listview/manga_listview_model.dart';
import 'package:leitor_manga/app/shared/pageable/pageable_store_interface.dart';
import 'package:mobx/mobx.dart';

part 'last_manga_with_update_store.g.dart';

class LastMangaWithUpdateStore = _LastMangaWithUpdateStoreBase
    with _$LastMangaWithUpdateStore;

abstract class _LastMangaWithUpdateStoreBase
    with Store
    implements IPageableStore<MangaListViewModel> {
  final mangaService = Modular.get<MangaService>();

  // ignore: annotate_overrides
  int qtyPages;

  @override
  @observable
  ObservableList<MangaListViewModel> items =
      ObservableList<MangaListViewModel>();

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
  @computed
  bool get hasError {
    return error != null;
  }

  @override
  @computed
  bool get hasErrorOnGetMoreItems {
    return errorOnGetMoreItems != null;
  }

  @override
  @action
  Future<void> loadItems() async {
    loading = true;
    error = null;
    loadingMoreItems = false;
    errorOnGetMoreItems = null;

    try {
      items = (await mangaService.getLastMangaWithUpdate()).asObservable();
    } catch (err) {
      error = err;
    }

    loading = false;
  }

  @override
  @action
  Future<void> loadMoreItems() async {
    loadingMoreItems = true;
    errorOnGetMoreItems = null;

    try {
      items.addAll(await mangaService.getLastMangaWithUpdate(
        offset: items.length,
      ));
    } catch (err) {
      errorOnGetMoreItems = err;
    }

    loadingMoreItems = false;
  }
}
