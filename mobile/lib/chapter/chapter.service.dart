import 'package:leitor_manga/chapter/list/chapter-list.dto.dart';
import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/config/dio_config.dart';

class ChapterService {
  Future<List<ChapterListDto>> getList(
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
          .map((dynamic json) => ChapterListDto.fromJson(json))
          .toList()
          .cast<ChapterListDto>();
    }

    return null;
  }

  Future<ChapterDto> getChapter(int chapterId) async {
    final dio = await DioConfig.withToken();
    var res = await dio.get('/api/v1/chapter/$chapterId');

    if (res.statusCode == 200) {
      return ChapterDto.fromJson(res.data);
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
