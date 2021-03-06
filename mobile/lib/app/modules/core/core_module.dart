import 'package:leitor_manga/app/modules/core/pages/category_single/category_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/category_single/category_single_page.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/chapter_single_page.dart';
import 'package:leitor_manga/app/modules/core/pages/feed/feed_page.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/all_mangas_store.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/category_list/category_list_store.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/last_manga_with_update/last_manga_with_update_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list_readed_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_favorite/manga_favorite_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/manga_single_controller.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/manga_single_page.dart';
import 'package:leitor_manga/app/modules/core/pages/user/user_page.dart';
import 'package:leitor_manga/app/modules/core/routes.dart';
import 'package:leitor_manga/app/modules/core/shared/category.service.dart';
import 'package:leitor_manga/app/modules/core/shared/chapter.service.dart';
import 'package:leitor_manga/app/modules/core/shared/manga.service.dart';
import 'package:leitor_manga/app/shared/notifications/firebase_notifications.service.dart';

import 'pages/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'pages/home/home_page.dart';

class CoreModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController()),
        Bind(
          (i) => AllMangasStore(homeController: i.get<HomeController>()),
          singleton: false,
        ),
        Bind((i) => LastMangaWithUpdateStore()),
        Bind((i) => MangaService(
            firebaseNotifications: i.get<FirebaseNotifications>())),
        Bind((i) => MangaFavoriteStore(mangaService: i.get<MangaService>())),
        Bind((i) => MangaSingleController(
              mangaService: i.get<MangaService>(),
              mangaFavoriteStore: i.get<MangaFavoriteStore>(),
            )),
        Bind((i) => ChapterService()),
        Bind((i) => ChapterListReadedStore()),
        Bind((i) => ChapterSingleController(), singleton: false),
        Bind((i) => CategoryService()),
        Bind((i) => CategoriesStore()),
        Bind((i) => CategorySingleController()),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
        Router(Routes.USER, child: (_, args) => UserPage()),
        Router(Routes.FEED, child: (_, args) => FeedPage()),
        Router(
          Routes.MANGA_SINGLE,
          child: (_, args) => MangaSinglePage(
            mangaId: int.parse(args.params['mangaId']),
          ),
        ),
        Router(
          Routes.CHAPTER_SINGLE,
          child: (_, args) => ChapterSinglePage(
            mangaId: int.parse(args.params['mangaId']),
            chapterId: int.parse(args.params['chapterId']),
          ),
        ),
        Router(
          Routes.CATEGORY_SINGLE,
          child: (_, args) => CategorySinglePage(
            categoryId: int.parse(args.params['categoryId']),
            categoryName: args.params['categoryName'],
          ),
        ),
      ];

  static Inject get to => Inject<CoreModule>.of();
}
