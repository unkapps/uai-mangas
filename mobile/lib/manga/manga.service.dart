import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/config/dio_config.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';

class MangaService {
  static final Dio dio = DioConfig.dio;

  Future<MangaDto> getManga(int mangaId) async {
    Response res = await dio.get('/manga/$mangaId');

    if (res.statusCode == 200) {
      return MangaDto.fromJson(res.data);
    }

    return null;
  }

  Future<List<LastMangaWithUpdateDto>> getLastMangaWithUpdate() async {
    Response res = await dio.get(
      '/manga/last',
      queryParameters: {
        'size': '3',
      },
    );

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic json) => LastMangaWithUpdateDto.fromJson(json))
          .toList()
          .cast<LastMangaWithUpdateDto>();
    }

    debugPrint('${res.statusCode}');

    return null;
  }
}
