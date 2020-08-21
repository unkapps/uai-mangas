import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_model.dart';
import 'package:leitor_manga/app/shared/config/dio_config.dart';

class ChapterService {
  Future<List<ChapterListModel>> getList(
      int mangaId, int size, int offset, bool desc) async {
    final dio = await DioConfig.withToken();
    var res = await dio.get('/api/v1/chapter/', queryParameters: {
      'mangaId': '$mangaId',
      'size': '$size',
      'offset': offset,
      'sort': desc ? 'DESC' : 'ASC',
    });

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic json) => ChapterListModel.fromJson(json))
          .toList()
          .cast<ChapterListModel>();
    }

    return null;
  }

  Future<ChapterSingleModel> getChapter(int chapterId) async {
    final dio = await DioConfig.withToken();
    var res = await dio.get('/api/v1/chapter/$chapterId');

    if (res.statusCode == 200) {
      return ChapterSingleModel.fromJson(res.data);
    }

    return null;
  }

  Future<bool> setChapterReaded(int chapterId, bool chapterReaded) async {
    final dio = await DioConfig.withToken(tokenIsRequired: true);
    var res = await dio.put<String>(
      '/api/v1/chapter/readed/$chapterId',
      queryParameters: {
        'chapterReaded': chapterReaded,
      },
    );

    if (res.statusCode == 200) {
      return res.data.toLowerCase() == 'true';
    }

    return null;
  }
}
