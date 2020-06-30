import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:leitor_manga/feed/bloc/feed_bloc.dart';
import 'package:leitor_manga/manga/list/manga_list_gridview.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last_manga_with_update_listview.dart';

typedef FeedBodyBuilder = Widget Function(BuildContext context);

class FeedPage extends StatefulWidget {
  FeedPage({Key key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  PageStorageKey _newsKey;
  PageStorageKey _unreadKey;
  PageStorageKey _othersKey;

  @override
  void initState() {
    _newsKey = PageStorageKey('feed_n');
    _unreadKey = PageStorageKey('feed_u');
    _othersKey = PageStorageKey('feed_o');

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (BuildContext context, FeedState state) {
        return _getScaffold(
          context,
          tabs: state is FeedLoaded,
          feedBodyBuilder: (BuildContext context) {
            if (state is FeedLoaded) {
              return TabBarView(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: LastMangaWithUpdateListView(
                      key: _newsKey,
                      mangas: state.news,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: MangaListGridView(
                      key: _unreadKey,
                      mangas: state.unread,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: MangaListGridView(
                      key: _othersKey,
                      mangas: state.others,
                    ),
                  ),
                ],
              );
            }

            if (state is FeedError) {
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
                      setState(() {
                        context.bloc<FeedBloc>().add(LoadFeedEvent());
                      });
                    },
                  ),
                ),
              );
            }

            if (state is FeedLoading) {
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

            SchedulerBinding.instance.addPostFrameCallback((_) async {
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
