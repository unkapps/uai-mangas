import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/category_list/category_list_model.dart';
import 'package:leitor_manga/app/modules/core/shared/category.service.dart';
import 'package:mobx/mobx.dart';

part 'category_list_store.g.dart';

class CategoriesStore = _CategoriesStoreBase
    with _$CategoriesStore;

abstract class _CategoriesStoreBase with Store {
  final categoryService = Modular.get<CategoryService>();

  @observable
  ObservableFuture<List<CategoryListModel>> categories;

  _CategoriesStoreBase() {
    load();
  }

  @action
  Future<void> load() async {
    categories = categoryService.getAllCategories().asObservable();
  }
}
