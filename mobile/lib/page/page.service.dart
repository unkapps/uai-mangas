import 'dart:convert';

import 'package:http/http.dart';
import 'package:leitor_manga/config/environment_config.dart';
import 'package:leitor_manga/page/page.dto.dart';

class PageService {
  Future<List<PageDto>> getPages() async {
    var queryParameters = {
      'chapterId': "12682",
    };

    Response res = await get(
        Uri.http(EnvironmentConfig.SITE_ADDRESS, '/page', queryParameters));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<PageDto> chapters = body
          .map(
            (dynamic item) => PageDto.fromJson(item),
          )
          .toList();

      return chapters;
    }
  }
}
