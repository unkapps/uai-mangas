import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/all_mangas.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/category_list/category_list.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/drawer_count.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/home_drawer.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/last_manga_with_update/last_manga_with_update.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/search/search_app_bar.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:leitor_manga/app/shared/changelog/changelog_service.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';
import 'package:leitor_manga/app/shared/version/version_store.dart';
import 'package:pedantic/pedantic.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final authStore = Modular.get<AuthStore>();
  final feedStore = Modular.get<FeedStore>();
  final versionStore = Modular.get<VersionStore>();

  final String title;
  HomePage({
    Key key,
    this.title = 'Uai Mangás',
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  PageStorageKey _lastMangaWithUpdateKey;
  PageStorageKey _allMangaKey;
  PageStorageKey _categoriesKey;
  GlobalKey _searchKey;

  String _lastQuery;

  @override
  void initState() {
    _lastMangaWithUpdateKey = PageStorageKey('l');
    _allMangaKey = PageStorageKey('a');
    _categoriesKey = PageStorageKey('c');
    _searchKey = GlobalKey();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: SearchAppBar(
          homeController: controller,
          appBar: AppBar(
            title: Text(widget.title),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Recente'),
                Tab(text: 'Todos'),
                Tab(text: 'Categorias'),
              ],
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return DrawerCount();
              },
            ),
          ),
        ),
        drawer: HomeDrawer(
          authStore: widget.authStore,
          feedStore: widget.feedStore,
        ),
        body: Observer(
          builder: (_) {
            if (!controller.searchMode) {
              if (widget.versionStore.versionLoaded) {
                unawaited(ChangelogService.openDialogFirstTime(
                    context, widget.versionStore.versionCode));
              }

              return TabBarView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: LastMangaWithUpdate(key: _lastMangaWithUpdateKey),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: AllMangas(
                      key: _allMangaKey,
                      showCount: true,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: CategoryList(
                      key: _categoriesKey,
                    ),
                  ),
                ],
              );
            }

            if (_lastQuery != controller.query) {
              _searchKey = GlobalKey();
              _allMangaKey = PageStorageKey(_allMangaKey.value + '2');
            }

            _lastQuery = controller.query;

            return Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: AllMangas(
                key: _searchKey,
                showCount: true,
                mangaName: controller.query,
              ),
            );
          },
        ),
      ),
    );
  }
}
