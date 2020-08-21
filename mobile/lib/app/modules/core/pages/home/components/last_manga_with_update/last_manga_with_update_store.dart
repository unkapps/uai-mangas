import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/shared/manga.service.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_listview/manga_listview_model.dart';
import 'package:mobx/mobx.dart';

part 'last_manga_with_update_store.g.dart';

class LastMangaWithUpdateStore = _LastMangaWithUpdateStoreBase
    with _$LastMangaWithUpdateStore;

abstract class _LastMangaWithUpdateStoreBase with Store {
  final mangaService = Modular.get<MangaService>();

  @observable
  ObservableList<MangaListViewModel> mangas = ObservableList<MangaListViewModel>();

  @observable
  Object error;

  @observable
  bool loading = false;

  @computed
  bool get hasError {
    return error != null;
  }

  @action
  Future<void> loadMangas() async {
    loading = true;
    error = null;

    try {
      mangas = (await mangaService.getLastMangaWithUpdate()).asObservable();
    } catch (err) {
      error = err;
    }

    loading = false;
  }
}
