import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/config/dio_config.dart';
import 'package:leitor_manga/firebase/notifications/firebase_notifications.service.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';
import 'package:leitor_manga/manga/list/manga_list.dto.dart';
import 'package:leitor_manga/manga/manga_sort.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';
import 'package:leitor_manga/shared/pageable.dto.dart';
import 'package:leitor_manga/feed/favorite_manga.dto.dart';

class MangaService {
  static final getIt = GetIt.instance;
  final FirebaseNotifications firebaseNotifications =
      getIt<FirebaseNotifications>();

  Future<MangaDto> getManga(int mangaId) async {
    final dio = await DioConfig.withToken();
    var res = await dio.get('/manga/$mangaId');

    if (res.statusCode == 200) {
      return MangaDto.fromJson(res.data);
    }

    return null;
  }

  Future<List<FavoriteMangaDto>> getFavoriteMangas() async {
    final dio = await DioConfig.withToken();
    var res = await dio.get(
      '/manga/favorite/',
    );

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic json) => FavoriteMangaDto.fromJson(json))
          .toList()
          .cast<FavoriteMangaDto>();
    }

    return null;
  }

  Future<bool> setMangaFavorite(int mangaId, bool mangaFavorite) async {
    var fcmToken = await firebaseNotifications.firebaseMessaging.getToken();
    final dio = await DioConfig.withToken();
    var res = await dio.put<String>(
      '/manga/favorite/$mangaId',
      queryParameters: {
        'mangaFavorite': mangaFavorite,
        'fcmToken': fcmToken,
      },
    );

    if (res.statusCode == 200) {
      return res.data.toLowerCase() == 'true';
    }

    return null;
  }

  Future<List<LastMangaWithUpdateDto>> getLastMangaWithUpdate() async {
    final dio = await DioConfig.withoutToken();
    try {
      var res = await dio.get(
        '/manga/last',
        queryParameters: {
          'size': 6,
        },
      );

      if (res.statusCode == 200) {
        return res.data
            .map((dynamic json) => LastMangaWithUpdateDto.fromJson(json))
            .toList()
            .cast<LastMangaWithUpdateDto>();
      }
    } catch (err) {
      debugPrint(err);
    }

    return null;
  }

  Map<String, dynamic> _getQueryParamatersForAllManga(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) {
    var sort = sortingChoice.sort;

    var queryParameters = <String, dynamic>{
      'size': 9,
      'sorting': sort.toString(),
    };

    if (name != null) {
      queryParameters['name'] = name;
    }

    if (offset != null) {
      queryParameters['offset'] = offset;
    }

    return queryParameters;
  }

  Future<PageableDto<MangaListDto>> getAllManga(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) async {
    final dio = await DioConfig.withoutToken();
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
    final dio = await DioConfig.withToken();
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
