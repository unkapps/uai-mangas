import 'package:extended_future_builder/extended_future_builder.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:leitor_manga/manga/list/manga_list.dto.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/manga_sort.dart';
import 'package:leitor_manga/manga/list/manga_list_gridview.dart';

import 'package:leitor_manga/shared/infinite_scroll.dart';
import 'package:leitor_manga/shared/pageable.dto.dart';

class MangaList extends StatefulWidget {
  final bool showCount;
  final String mangaName;

  MangaList({
    Key key,
    bool showCount,
    this.mangaName,
  })  : showCount = showCount ?? false,
        super(key: key);

  @override
  _MangaListState createState() => _MangaListState();
}

class _MangaListState extends State<MangaList> {
  static final getIt = GetIt.instance;
  final MangaService mangaService = getIt<MangaService>();

  MangaSortingChoice _sortingChoice;

  GlobalKey _globalKey;

  @override
  void initState() {
    _sortingChoice = widget.mangaName != null
        ? MangaSortingChoice.RELEVANCE
        : MangaSortingChoice.NAME;
    _globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExtendedFutureBuilder<PageableDto<MangaListDto>>(
        key: _globalKey,
        futureResponseBuilder: () =>
            mangaService.getAllManga(_sortingChoice, name: widget.mangaName),
        errorBuilder: (BuildContext context, error) {
          return Center(
            child: Text('Erro! Clique para tentar novamente.'),
          );
        },
        successBuilder: (BuildContext context, PageableDto<MangaListDto> page) {
          var mangas = page.data;
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Visibility(
                        child: Text(
                          '${page.qtyPages} mangás',
                          style: theme.textTheme.subtitle1,
                        ),
                        visible: widget.showCount,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: MangaSort(
                              initialSorting: _sortingChoice,
                              onSearch: widget.mangaName != null,
                              onSortChanged:
                                  (MangaSortingChoice sortingChoice) {
                                setState(() {
                                  _sortingChoice = sortingChoice;
                                  _globalKey = GlobalKey();
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: InkWell(
                              child: Icon(Icons.refresh),
                              onTap: () {
                                setState(() {
                                  _globalKey = GlobalKey();
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: InfiniteScroll<MangaListDto>(
                  color: theme.accentColor,
                  length: mangas.length,
                  limit: page.qtyPages,
                  getMoreItems: () => mangaService.getAllMangaWithoutCount(
                    _sortingChoice,
                    offset: mangas.length,
                    name: widget.mangaName,
                  ),
                  onNewItemsReceived: (List<MangaListDto> items) {
                    setState(() {
                      mangas.addAll(items);
                    });
                  },
                  child: MangaListGridView(mangas: mangas),
                ),
              ),
            ],
          );
        });
  }
}
