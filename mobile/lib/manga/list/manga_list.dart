import 'package:extended_future_builder/extended_future_builder.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:leitor_manga/manga/list/manga_list.dto.dart';
import 'package:leitor_manga/manga/manga.service.dart';
import 'package:leitor_manga/manga/manga_sort.dart';
import 'package:leitor_manga/manga/single/manga.page.dart';
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
  final mangaService = MangaService();

  MangaSortingChoice _sortingChoice;

  GlobalKey _globalKey;

  @override
  void initState() {
    _sortingChoice = MangaSortingChoice.NAME;
    _globalKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final columnWidth = 150.0;

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
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: mangas.length,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: columnWidth,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      //childAspectRatio: 0.40,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 0.85),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      var manga = mangas[index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MangaPage(mangaId: manga.id)),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: theme.dividerColor,
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                //  width: columnWidth,
                                //   height: 200,
                                child: ExtendedImage.network(
                                  manga.coverUrl,
                                  fit: BoxFit.fitHeight,
                                  width: columnWidth,
                                  alignment: Alignment.topCenter,
                                  cache: true,
                                  retries: 0,
                                  loadStateChanged: (ExtendedImageState state) {
                                    switch (state.extendedImageLoadState) {
                                      case LoadState.failed:
                                        return Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                          size: 50,
                                        );
                                      default:
                                        return null;
                                    }
                                  },
                                ),
                              ),
                              SizedBox(
                                //  fit: BoxFit.,
                                height: 60.4,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    manga.name,
                                    style: theme.textTheme.subtitle1,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
