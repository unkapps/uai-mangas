import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:extended_image/extended_image.dart';
import 'package:leitor_manga/firebase/admob/admob_ads_id.dart';
import 'package:leitor_manga/firebase/admob/admob_banner_wrapper.dart';

import 'package:leitor_manga/manga/list/manga_list.dto.dart';
import 'package:leitor_manga/manga/single/manga.page.dart';

class MangaListGridView extends StatelessWidget {
  final List<MangaListDto> mangas;

  final adPosition = 5;

  MangaListGridView({Key key, @required this.mangas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final columnWidth = 150.0;

    final theme = Theme.of(context);

    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: AdmobBannerWrapper(
              adUnitId: AdmobIdsId.LIST_GRIDVIEW,
              adSize: AdmobBannerSize.ADAPTIVE_BANNER(
                  width: MediaQuery.of(context).size.width.toInt()),
            ),
          ),
          GridView.builder(
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
                    CupertinoPageRoute(
                        builder: (context) => MangaPage(mangaId: manga.id)),
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
        ],
      ),
    );
  }
}
