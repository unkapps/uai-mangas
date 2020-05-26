import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:leitor_manga/page/page.dto.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MangaPageVerticalListView extends StatefulWidget {
  MangaPageVerticalListView(this.pages, {Key key, this.onPageChange})
      : super(key: key);

  final Function(int) onPageChange;
  final List<PageDto> pages;

  @override
  _MangaPageVerticalListViewState createState() =>
      _MangaPageVerticalListViewState(this.pages);
}

class _MangaPageVerticalListViewState extends State<MangaPageVerticalListView> {
  final List<PageDto> pages;

  _MangaPageVerticalListViewState(this.pages);
  var currentIndex = 0;
  var qtyLoaded = 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          var page = pages[position];
          var imageLoaded = false;

          return VisibilityDetector(
            key: Key('detector-$page'),
            onVisibilityChanged: (VisibilityInfo info) {
              if (imageLoaded && widget.onPageChange != null) {
                setState(() {
                  widget.onPageChange(position);
                });
              }
            },
            child: Transform.scale(
              scale: 1,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (position > qtyLoaded) {
                    return Container();
                  }
                  return ExtendedImage.network(
                    page.imageUrl,
                    fit: BoxFit.fitWidth,
                    mode: ExtendedImageMode.none,
                    cache: true,
                    loadStateChanged: (ExtendedImageState state) {
                      switch (state.extendedImageLoadState) {
                        case LoadState.completed:
                          imageLoaded = true;
                          return null;
                        case LoadState.failed:
                          return null;
                        case LoadState.loading:
                          return null;
                      }
                    },
                  );
                },
              ),
            ),
          );
        },
        itemCount: pages.length,
      ),
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 500 &&
            qtyLoaded < pages.length) {
          setState(() {
            qtyLoaded += 3;
          });
        }

        return false;
      },
    );
  }
}
