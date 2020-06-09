import 'dart:convert';

import 'package:http/http.dart';
import 'package:leitor_manga/chapter/list/chapter-list.dto.dart';
import 'package:leitor_manga/chapter/single/chapter.dto.dart';
import 'package:leitor_manga/config/environment_config.dart';

class ChapterService {
  Future<List<ChapterListDto>> getList(int mangaId, int size, int offset) async {
    Response res = await get(
        Uri.http(EnvironmentConfig.SITE_ADDRESS, '/chapter/', {
      'mangaId': '$mangaId',
      'size': '$size',
      'offset': '$offset',
    }));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      return body.map((dynamic json) => ChapterListDto.fromJson(json)).toList().cast<ChapterListDto>();
    }

    return null;
  }

  Future<ChapterDto> getChapter(int chapterId) async {
    Response res = await get(
        Uri.http(EnvironmentConfig.SITE_ADDRESS, '/chapter/$chapterId'));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      return ChapterDto.fromJson(body);
    }

    return null;
  }
}
