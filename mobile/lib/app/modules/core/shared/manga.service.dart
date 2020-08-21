import 'package:flutter/cupertino.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/manga_sort.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_single_model.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_gridview/manga_gridview_model.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_listview/manga_listview_model.dart';
import 'package:leitor_manga/app/shared/config/dio_config.dart';
import 'package:leitor_manga/app/shared/notifications/firebase_notifications.service.dart';
import 'package:leitor_manga/app/shared/pageable/pageable.dto.dart';

class MangaService {
  final FirebaseNotifications firebaseNotifications;

  MangaService({@required this.firebaseNotifications});

  Future<MangaSingleModel> getManga(int mangaId) async {
    final dio = await DioConfig.withToken();
    var res = await dio.get('/api/v1/manga/$mangaId');

    if (res.statusCode == 200) {
      return MangaSingleModel.fromJson(res.data);
    }

    return null;
  }

  Future<List<MangaListViewModel>> getLastMangaWithUpdate() async {
    final dio = await DioConfig.withoutToken();
    try {
      var res = await dio.get(
        '/api/v1/manga/last',
        queryParameters: {
          'size': 6,
        },
      );

      if (res.statusCode == 200) {
        return res.data
            .map((dynamic json) => MangaListViewModel.fromJson(json))
            .toList()
            .cast<MangaListViewModel>();
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

  Future<PageableDto<MangaGridViewModel>> getAllManga(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) async {
    final dio = await DioConfig.withoutToken();
    var res = await dio.get(
      '/api/v1/manga',
      queryParameters: _getQueryParamatersForAllManga(sortingChoice,
          name: name, offset: offset),
    );

    if (res.statusCode == 200) {
      return PageableDto<MangaGridViewModel>.fromJson(res.data, (dynamic json) {
        return json
            .map((dynamic jsonPage) => MangaGridViewModel.fromJson(jsonPage))
            .toList()
            .cast<MangaGridViewModel>();
      });
    }

    return null;
  }

  Future<List<MangaGridViewModel>> getAllMangaWithoutCount(
    MangaSortingChoice sortingChoice, {
    String name,
    int offset,
  }) async {
    final dio = await DioConfig.withToken();
    var res = await dio.get(
      '/api/v1/manga/loadMore',
      queryParameters: _getQueryParamatersForAllManga(sortingChoice,
          name: name, offset: offset),
    );

    if (res.statusCode == 200) {
      return res.data
          .map((dynamic jsonPage) => MangaGridViewModel.fromJson(jsonPage))
          .toList()
          .cast<MangaGridViewModel>();
    }

    return null;
  }

  Future<bool> setMangaFavorite(int mangaId, bool mangaFavorite) async {
    var fcmToken = await firebaseNotifications.firebaseMessaging.getToken();
    final dio = await DioConfig.withToken();
    var res = await dio.put<String>(
      '/api/v1/manga/favorite/$mangaId',
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
}
