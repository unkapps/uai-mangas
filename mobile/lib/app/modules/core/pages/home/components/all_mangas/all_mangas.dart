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
  final int categoryId;

  AllMangas({
    Key key,
    bool showCount,
    this.mangaName,
    this.categoryId,
  })  : showCount = showCount ?? false,
        super(key: key);

  @override
  _AllMangasState createState() => _AllMangasState();
}

class _AllMangasState extends State<AllMangas> {
  final allMangasStore = Modular.get<AllMangasStore>();

  @override
  void initState() {
    allMangasStore.init(widget.mangaName, categoryId: widget.categoryId);
    allMangasStore.loadItems();
    super.initState();
  }

  String textoQuantidade() {
    var texto = '${allMangasStore.qtyPages} mangá';
    if (allMangasStore.qtyPages > 1) {
      texto += 's';
    }
    return texto;
  }

  String textoListaVazia() {
    var texto = 'Nenhum mangá ';
    if (widget.categoryId != null) {
      texto += 'nessa categoria';
    } else {
      texto += 'retornado pela busca';
    }
    return texto;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Observer(
      builder: (_) {
        if (allMangasStore.hasError) {
          return InkWell(
            child: Center(
              child: Text('Erro! Clique para tentar novamente.'),
            ),
            onTap: () {
              allMangasStore.loadItems();
            },
          );
        }

        if (allMangasStore.loading) {
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
                        textoQuantidade(),
                        style: theme.textTheme.subtitle1,
                      ),
                      visible: widget.showCount && allMangasStore.qtyPages != 0,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: MangaSort(
                            sortableStore: allMangasStore,
                            onSearch: widget.mangaName != null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: InkWell(
                            child: Icon(Icons.refresh),
                            onTap: () {
                              allMangasStore.loadItems();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              child: Column(children: <Widget>[
                Icon(
                  Icons.warning,
                  size: 48,
                ),
                Text(
                  textoListaVazia(),
                  style: theme.textTheme.subtitle1,
                ),
              ]),
              visible: allMangasStore.qtyPages == 0,
            ),
            Expanded(
              child: InfiniteScroll<MangaGridViewModel>(
                color: theme.accentColor,
                length: allMangasStore.items.length,
                limit: allMangasStore.qtyPages,
                pageableStore: allMangasStore,
                child: MangaGridView(mangas: allMangasStore.items),
              ),
            ),
          ],
        );
      },
    );
  }
}
