import 'package:dio/dio.dart';
import 'package:leitor_manga/chapter/list/chapter-list.dto.dart';
import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/config/dio_config.dart';

class ChapterService {
  static final Dio dio = DioConfig.dio;

  Future<List<ChapterListDto>> getList(
      int mangaId, int size, int offset) async {
    Response res = await dio.get('/chapter/', queryParameters: {
      'mangaId': '$mangaId',
      'size': '$size',
      'offset': '$offset',
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
    Response res = await dio.get('/chapter/$chapterId');

    if (res.statusCode == 200) {
      return ChapterDto.fromJson(res.data);
    }

    return null;
  }
}