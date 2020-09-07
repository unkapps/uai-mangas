import 'package:admob_flutter/admob_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/author/author_model.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/author/authors.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/category/categories.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_item.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/chapter_list/chapter_list.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_favorite/manga_favorite.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_favorite/manga_favorite_store.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/manga_single_model.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/manga_single_controller.dart';
import 'package:leitor_manga/app/shared/admob/admob_ads_id.dart';
import 'package:leitor_manga/app/shared/admob/admob_banner_wrapper.dart';
import 'package:leitor_manga/app/shared/auth/auth_store.dart';
import 'package:leitor_manga/app/shared/auth/login_dialog.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';
import 'package:leitor_manga/app/shared/rateapp/rateapp_dialog.dart';
import 'package:mobx/mobx.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MangaSinglePage extends StatefulWidget {
  final int mangaId;

  MangaSinglePage({Key key, @required this.mangaId}) : super(key: key);

  @override
  _MangaSinglePageState createState() => _MangaSinglePageState();
}

class _MangaSinglePageState
    extends ModularState<MangaSinglePage, MangaSingleController> {
  final authStore = Modular.get<AuthStore>();
  final feedStore = Modular.get<FeedStore>();
  final mangaFavoriteStore = Modular.get<MangaFavoriteStore>();

  GlobalKey<ChapterListState> _chapterListPageKey;

  ScrollController _scrollController;

  ProgressDialog _progressDialog;

  _MangaSinglePageState();

  ReactionDisposer authReactionDisposer;

  @override
  void initState() {
    _chapterListPageKey = GlobalKey();
    _scrollController = ScrollController();

    authReactionDisposer = autorun((_) {
      if (_progressDialog != null) {
        _progressDialog.hide();
      }

      if (authStore.isLoading) {
        _progressDialog = ProgressDialog(context,
            type: ProgressDialogType.Normal,
            isDismissible: false,
            showLogs: false);
        _progressDialog.show();
      } else {
        controller.loadManga(widget.mangaId);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    authReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            return Text(controller.pageTitle);
          },
        ),
      ),
      body: Observer(
        builder: (_) {
          if (controller.manga.status == FutureStatus.rejected) {
            return InkWell(
              child: Center(
                child: Text('Erro! Clique para tentar novamente.'),
              ),
              onTap: () {
                controller.loadManga(widget.mangaId);
              },
            );
          }

          if (controller.manga.status == FutureStatus.pending) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.manga.status == FutureStatus.fulfilled) {
            return _buildSuccess(context, controller.manga.value);
          }

          return Container();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, MangaSingleModel manga) {
    var authors = List<AuthorModel>.from(manga.authors);
    authors.addAll(manga.artists);

    var size = MediaQuery.of(context).size;

    return NotificationListener(
      child: ListView(
        controller: _scrollController,
        children: <Widget>[
          ExtendedImage.network(
            manga.coverUrl,
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            height: size.height * 0.6,
            width: size.width,
            cache: true,
            loadStateChanged: (ExtendedImageState state) {
              switch (state.extendedImageLoadState) {
                case LoadState.failed:
                  return Icon(
                    Icons.broken_image,
                    color: Colors.grey,
                    size: 100,
                  );
                default:
                  return null;
              }
            },
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: SizedBox(
                height: 15,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Authors(
                          authors: authors,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: MangaFavorite(),
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              )),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ExpandablePanel(
              theme:
                  ExpandableThemeData(iconColor: Theme.of(context).accentColor),
              header: Text('Resumo'),
              collapsed: Text(
                manga.description,
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
              ),
              expanded: Text(
                manga.description,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Categories(
            categories: manga.categories,
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: AdmobBannerWrapper(
              adUnitId: AdmobIdsId.MANGA_SINGLE_PAGE,
              adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                  width: MediaQuery.of(context).size.width.toInt()),
            ),
          ),
          RateApp(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Próxima leitura'),
          ),
          Observer(
            builder: (_) {
              if (mangaFavoriteStore.loading || feedStore.loading) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 24.0, horizontal: 10),
                    child: Container(
                      width: 24,
                      height: 24,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }

              if (authStore.isAuthenticated) {
                if (feedStore.hasError) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20,
                    ),
                    child: InkWell(
                      child: Center(
                        child: Text('Erro! Clique para tentar novamente.'),
                      ),
                      onTap: () {
                        feedStore.load();
                      },
                    ),
                  );
                }

                final mangaDto = [
                  ...feedStore.news,
                  ...feedStore.others
                ].firstWhere((m) => m.id == widget.mangaId, orElse: () => null);

                if (mangaDto != null) {
                  if (mangaDto.nextChapterId != null) {
                    return ChapterItem(
                      chapterId: mangaDto.nextChapterId,
                      mangaId: widget.mangaId,
                      number: mangaDto.nextChapterNumber,
                      date: mangaDto.date,
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20,
                      ),
                      child: Text('Todos capitulos já foram lidos'),
                    );
                  }
                } else {
                  return Column(
                    children: [
                      // TODO don't do a request for this
                      ChapterList(
                        qtyChapters: manga.qtyChapters,
                        mangaId: manga.id,
                        allowFetchMore: false,
                        initialFetch: 1,
                        desc: false,
                      ),
                      mangaFavoriteStore.favorite
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 20,
                              ),
                              child: Text(
                                'Nota: Para exibição correta da próxima leitura é necessário favoritar este mangá.',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                    ],
                  );
                }
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20,
                  ),
                  child: InkWell(
                      onTap: () {
                        LoginDialog.createAndShowDialog(context,
                            fromFeature: true);
                      },
                      child: Column(children: <Widget>[
                        Icon(
                          Icons.warning,
                          size: 24,
                        ),
                        Text('Entre para ter aceso a essa funcionalidade'),
                      ])),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Capitulos'),
          ),
          ChapterList(
            qtyChapters: manga.qtyChapters,
            key: _chapterListPageKey,
            mangaId: manga.id,
          ),
        ],
      ),
      onNotification: (ScrollNotification scrollInfo) {
        if (_chapterListPageKey.currentState != null) {
          return _chapterListPageKey.currentState.onNotification(
              scrollInfo, _scrollController.position.maxScrollExtent);
        }
        return false;
      },
    );
  }
}
