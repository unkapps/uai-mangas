import 'package:dio/dio.dart';
import 'package:leitor_manga/config/dio_config.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';
import 'package:leitor_manga/manga/list/manga_list.dto.dart';
import 'package:leitor_manga/manga/manga_sort.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';
import 'package:leitor_manga/shared/pageable.dto.dart';

class MangaService {
  static final Dio dio = DioConfig.dio;

  Future<MangaDto> getManga(int mangaId) async {
    var res = await dio.get('/manga/$mangaId');

    if (res.statusCode == 200) {
      return MangaDto.fromJson(res.data);
    }

    return null;
  }

  Future<List<LastMangaWithUpdateDto>> getLastMangaWithUpdate() async {
    var res = await dio.get(
      '/manga/last',
      queryParameters: {
        'size': '4',
      },
    );

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic json) => LastMangaWithUpdateDto.fromJson(json))
          .toList()
          .cast<LastMangaWithUpdateDto>();
    }

    return null;
  }

  Map<String, String> _getQueryParamatersForAllManga(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) {
    var sort = sortingChoice.sort;

    var queryParameters = {
      'size': '9',
      'sorting': sort.toString(),
    };

    if (name != null) {
      queryParameters['name'] = name;
    }

    if (offset != null) {
      queryParameters['offset'] = offset.toString();
    }

    return queryParameters;
  }

  Future<PageableDto<MangaListDto>> getAllManga(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) async {
    var res = await dio.get(
      '/manga',
      queryParameters: _getQueryParamatersForAllManga(sortingChoice,
          name: name, offset: offset),
    );

    if (res.statusCode == 200) {
      return PageableDto<MangaListDto>.fromJson(res.data, (dynamic json) {
        return json
            .map((dynamic jsonPage) => MangaListDto.fromJson(jsonPage))
            .toList()
            .cast<MangaListDto>();
      });
    }

    return null;
  }

  Future<List<MangaListDto>> getAllMangaWithoutCount(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) async {
    var res = await dio.get(
      '/manga/loadMore',
      queryParameters: _getQueryParamatersForAllManga(sortingChoice,
          name: name, offset: offset),
    );

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic jsonPage) => MangaListDto.fromJson(jsonPage))
          .toList()
          .cast<MangaListDto>();
    }

    return null;
  }
}
