import 'package:flutter_modular/flutter_modular.dart';

class Routes {
  static const HOME = Modular.initialRoute;
  static const USER = '/user';
  static const FEED = '/feed';
  static const MANGA_SINGLE = '/manga/:mangaId';
  static const CHAPTER_SINGLE = '/manga/:mangaId/c/:chapterId';
  static const CATEGORY_SINGLE = '/category/:categoryName/:categoryId';
}
