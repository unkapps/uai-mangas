import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/all_mangas_store.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/all_mangas/manga_sort.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_gridview/manga_gridview.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_gridview/manga_gridview_model.dart';
import 'package:leitor_manga/app/shared/pageable/infinite_scroll.dart';

class AllMangas extends StatefulWidget {
  final bool showCount;
  final String mangaName;

  final allMangasStore = Modular.get<AllMangasStore>();

  AllMangas({
    Key key,
    bool showCount,
    this.mangaName,
  })  : showCount = showCount ?? false,
        super(key: key);

  @override
  _AllMangasState createState() => _AllMangasState();
}

class _AllMangasState extends State<AllMangas> {
  @override
  void initState() {
    widget.allMangasStore.init(widget.mangaName);
    widget.allMangasStore.loadItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Observer(
      builder: (_) {
        if (widget.allMangasStore.hasError) {
          return InkWell(
            child: Center(
              child: Text('Erro! Clique para tentar novamente.'),
            ),
            onTap: () {
              widget.allMangasStore.loadItems();
            },
          );
        }

        if (widget.allMangasStore.loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Visibility(
                      child: Text(
                        '${widget.allMangasStore.qtyPages} mangás',
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
                            sortableStore: widget.allMangasStore,
                            onSearch: widget.mangaName != null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: InkWell(
                            child: Icon(Icons.refresh),
                            onTap: () {
                              widget.allMangasStore.loadItems();
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
              child: InfiniteScroll<MangaGridViewModel>(
                color: theme.accentColor,
                length: widget.allMangasStore.items.length,
                limit: widget.allMangasStore.qtyPages,
                pageableStore: widget.allMangasStore,
                child: MangaGridView(mangas: widget.allMangasStore.items),
              ),
            ),
          ],
        );
      },
    );
  }
}
