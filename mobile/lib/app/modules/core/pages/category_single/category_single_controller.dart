import 'package:leitor_manga/app/modules/core/pages/category_single/category_single_model.dart';
import 'package:mobx/mobx.dart';

part 'category_single_controller.g.dart';

class CategorySingleController = _CategorySingleControllerBase
    with _$CategorySingleController;

const double opacityChapterBar = 0.8;

abstract class _CategorySingleControllerBase with Store {
  @observable
  ObservableFuture<CategorySingleModel> category;

  @action
  void load(int categoryId) {
    // category = 
  }
}
