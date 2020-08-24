import 'package:leitor_manga/app/modules/core/pages/home/components/category_list/category_list_model.dart';
import 'package:leitor_manga/app/shared/config/dio_config.dart';

class CategoryService {
  Future<List<CategoryListModel>> getAllCategories() async {
    final dio = await DioConfig.withoutToken();
    var res = await dio.get('/api/v1/category');

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic json) => CategoryListModel.fromJson(json))
          .toList()
          .cast<CategoryListModel>();
    }

    return null;
  }
}
