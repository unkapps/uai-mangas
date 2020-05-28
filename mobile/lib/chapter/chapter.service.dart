import 'dart:convert';

import 'package:http/http.dart';
import 'package:leitor_manga/chapter/chapter.dto.dart';
import 'package:leitor_manga/config/environment_config.dart';

class ChapterService {
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
