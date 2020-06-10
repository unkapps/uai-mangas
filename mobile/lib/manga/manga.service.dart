import 'dart:convert';

import 'package:http/http.dart';
import 'package:leitor_manga/config/environment_config.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';

class MangaService {
  Future<MangaDto> getManga(int mangaId) async {
    Response res =
        await get(Uri.http(EnvironmentConfig.SITE_ADDRESS, '/manga/$mangaId'));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      return MangaDto.fromJson(body);
    }

    return null;
  }

  Future<List<LastMangaWithUpdateDto>> getLastMangaWithUpdate() async {
    Response res = await get(Uri.http(
      EnvironmentConfig.SITE_ADDRESS,
      '/manga/last',
      {
        'size': '5',
      },
    ));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body
          .map((dynamic json) => LastMangaWithUpdateDto.fromJson(json))
          .toList()
          .cast<LastMangaWithUpdateDto>();
    }

    return null;
  }
}
