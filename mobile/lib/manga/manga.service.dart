import 'dart:convert';

import 'package:http/http.dart';
import 'package:leitor_manga/config/environment_config.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';

class MangaService {
  Future<MangaDto> getManga(int mangaId) async {
    Response res = await get(
        Uri.http(EnvironmentConfig.SITE_ADDRESS, '/manga/$mangaId'));

    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);

      return MangaDto.fromJson(body);
    }

    return null;
  }
}
