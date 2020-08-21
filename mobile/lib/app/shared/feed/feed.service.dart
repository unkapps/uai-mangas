import 'package:leitor_manga/app/shared/config/dio_config.dart';
import 'package:leitor_manga/app/shared/feed/favorite_manga.dto.dart';

class FeedService {
  Future<List<FavoriteMangaDto>> getFavoriteMangas() async {
    final dio = await DioConfig.withToken();
    var res = await dio.get(
      '/api/v1/manga/favorite/',
    );

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic json) => FavoriteMangaDto.fromJson(json))
          .toList()
          .cast<FavoriteMangaDto>();
    }

    return null;
  }
}
