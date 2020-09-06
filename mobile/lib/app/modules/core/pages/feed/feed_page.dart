import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_listview/manga_listview.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';

typedef FeedBodyBuilder = Widget Function(BuildContext context);

class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final feedStore = Modular.get<FeedStore>();

  PageStorageKey _newsKey;
  PageStorageKey _unreadKey;
  PageStorageKey _othersKey;

  @override
  void initState() {
    _newsKey = PageStorageKey('feed_n');
    _unreadKey = PageStorageKey('feed_u');
    _othersKey = PageStorageKey('feed_o');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return _getScaffold(
          context,
          tabs: feedStore.loaded,
          feedBodyBuilder: (BuildContext context) {
            if (feedStore.loaded) {
              return TabBarView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RefreshIndicator(
                      child: MangaListView(
                        key: _newsKey,
                        mangas: feedStore.news,
                      ),
                      onRefresh: () {
                        feedStore.load();
                        return Future.delayed(Duration(seconds: 0), () {});
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RefreshIndicator(
                      child: MangaListView(
                        key: _unreadKey,
                        mangas: feedStore.unread,
                      ),
                      onRefresh: () {
                        feedStore.load();
                        return Future.delayed(Duration(seconds: 0), () {});
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: RefreshIndicator(
                      child: MangaListView(
                        key: _othersKey,
                        mangas: feedStore.others,
                        showNextChapterButton: false,
                      ),
                      onRefresh: () {
                        feedStore.load();
                        return Future.delayed(Duration(seconds: 0), () {});
                      },
                    ),
                  ),
                ],
              );
            }

            if (feedStore.hasError) {
              return Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: InkWell(
                    child: Icon(
                      Icons.refresh,
                      size: 40,
                    ),
                    onTap: () {
                      feedStore.load();
                    },
                  ),
                ),
              );
            }

            if (feedStore.loading) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }

            SchedulerBinding.instance.scheduleFrameCallback((_) async {
              Navigator.pop(context);
            });

            return Container();
          },
        );
      },
    );
  }

  Widget _getScaffold(
    BuildContext context, {
    @required FeedBodyBuilder feedBodyBuilder,
    tabs = false,
  }) {
    Widget widget = Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
        bottom: tabs
            ? TabBar(
                tabs: [
                  Tab(text: 'Novos'),
                  Tab(text: 'Nunca lidos'),
                  Tab(text: 'Lidos'),
                ],
              )
            : null,
      ),
      body: feedBodyBuilder(context),
    );

    if (tabs) {
      widget = DefaultTabController(
        length: 3,
        child: widget,
      );
    }

    return widget;
  }
}
