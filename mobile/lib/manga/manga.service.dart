import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

  Future<PageableDto<MangaListDto>> getAllManga(
      MangaSortingChoice sortingChoice) async {
    var sort = sortingChoice.sort;

    var res = await dio.get(
      '/manga',
      queryParameters: {
        'size': '9',
        'sorting': sort.toString(),
      },
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
}
