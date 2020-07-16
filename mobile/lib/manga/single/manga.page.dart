import 'package:expandable/expandable.dart';
import 'package:extended_image/extended_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:get_it/get_it.dart';

import 'package:leitor_manga/author/author.dto.dart';
import 'package:leitor_manga/author/authors.dart';
import 'package:leitor_manga/category/categories.dart';
import 'package:leitor_manga/chapter/list/chapter_item.dart';
import 'package:leitor_manga/chapter/list/chapter_list.dart';
import 'package:leitor_manga/feed/bloc/feed_bloc.dart';
import 'package:leitor_manga/manga/single/bloc/manga_single_bloc.dart';
import 'package:leitor_manga/manga/single/manga-favorite/manga_favorite.dart';
import 'package:leitor_manga/manga/single/manga.dto.dart';
import 'package:leitor_manga/user/auth/bloc/auth_bloc.dart';
import 'package:leitor_manga/user/login_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MangaPage extends StatefulWidget {
  static final getIt = GetIt.instance;

  final int mangaId;

  MangaPage({Key key, @required this.mangaId}) : super(key: key);

  @override
  _MangaPageState createState() => _MangaPageState(mangaId: mangaId);
}

class _MangaPageState extends State<MangaPage> {
  final int mangaId;

  String _title;
  GlobalKey<ChapterListState> _chapterListPageKey;

  ScrollController _scrollController;

  ProgressDialog _progressDialog;

  _MangaPageState({@required this.mangaId});

  @override
  void initState() {
    _title = 'Carregando';

    _chapterListPageKey = GlobalKey();
    _scrollController = ScrollController();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: BlocProvider<MangaSingleBloc>(
        create: (context) {
          return MangaSingleBloc(widget.mangaId)..add(LoadMangaSingleEvent());
        },
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            if (state is Authenticated ||
                state is Unauthenticated ||
                state is LoginFailed) {
              await _progressDialog.hide();
              context.bloc<MangaSingleBloc>().add(LoadMangaSingleEvent());
            } else if (state is Loading) {
              _progressDialog = ProgressDialog(context,
                  type: ProgressDialogType.Normal,
                  isDismissible: false,
                  showLogs: false);
              await _progressDialog.show();
            }
          },
          child: BlocConsumer<MangaSingleBloc, MangaSingleState>(
            listener: (context, state) {
              if (state is MangaSingleError) {
                setState(() {
                  if (mounted) {
                    _title = 'Erro ao carregar :(';
                  }
                });
              }

              if (state is MangaSingleLoading) {
                setState(() {
                  if (mounted) {
                    _title = 'Carregando...';
                  }
                });
              }

              if (state is MangaSingleLoaded) {
                setState(() {
                  if (mounted) {
                    _title = state.manga.name;
                  }
                });
              }
            },
            builder: (BuildContext context, MangaSingleState state) {
              var bloc = context.bloc<MangaSingleBloc>();
              if (state is MangaSingleError) {
                return InkWell(
                  child: Center(
                    child: Text('Erro! Clique para tentar novamente.'),
                  ),
                  onTap: () {
                    bloc.add(LoadMangaSingleEvent());
                  },
                );
              }

              if (state is MangaSingleLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is MangaSingleLoaded) {
                return _buildSuccess(context, state.manga);
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, MangaDto manga) {
    var authors = List<AuthorDto>.from(manga.authors);
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Authors(
              authors: authors,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                MangaFavorite(
                  mangaId: manga.id,
                  favorite: manga.favorite,
                ),
              ],
            ),
          ),
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
            height: 140,
            margin: EdgeInsets.all(10),
            child: NativeAdmob(
              adUnitID: 'ca-app-pub-4719589372008331/8547336252',
              loading: Center(child: CircularProgressIndicator()),
              error: Text('Failed to load the ad'),
              type: NativeAdmobType.full,
              options: NativeAdmobOptions(
                ratingColor: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Próxima leitura'),
          ),
          BlocBuilder<FeedBloc, FeedState>(
            builder: (BuildContext context, FeedState state) {
              if (state is FeedLoading) {
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

              if (state is FeedLoaded) {
                final mangaDto = [
                  ...state.news,
                  ...state.others
                ].firstWhere((m) => m.id == widget.mangaId, orElse: () => null);

                if (mangaDto != null) {
                  if (mangaDto.nextChapterId != null) {
                    return ChapterItem(
                      chapterId: mangaDto.nextChapterId,
                      mangaId: widget.mangaId,
                      number: mangaDto.nextChapterNumber,
                      readed: false,
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
                  // TODO don't do a request for this
                  return ChapterList(
                    qtyChapters: manga.qtyChapters,
                    mangaId: manga.id,
                    allowFetchMore: false,
                    initialFetch: 1,
                    desc: false,
                  );
                }
              }

              if (state is FeedUnauthenticated) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20,
                  ),
                  child: InkWell(
                    onTap: () {
                      LoginDialog.createAndShowDialog(context);
                    },
                    child: Text('Entre para ter aceso a essa funcionalidade'),
                  ),
                );
              }

              return Container();
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
          manga.qtyChapters > 9
              ? Container(
                  height: 140,
                  margin: EdgeInsets.all(10),
                  child: NativeAdmob(
                    adUnitID: 'ca-app-pub-4719589372008331/8547336252',
                    loading: Center(child: CircularProgressIndicator()),
                    error: Text('Failed to load the ad'),
                    type: NativeAdmobType.full,
                    options: NativeAdmobOptions(
                      ratingColor: Colors.red,
                    ),
                  ),
                )
              : Container(),
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
