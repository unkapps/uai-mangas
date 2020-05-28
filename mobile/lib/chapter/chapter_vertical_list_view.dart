import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:leitor_manga/chapter/chapter.dto.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChapterVerticalListView extends StatefulWidget {
  ChapterVerticalListView(this.chapter, {Key key, this.chapterController})
      : super(key: key);

  final ChapterDto chapter;
  final ChapterController chapterController;

  @override
  _ChapterVerticalListViewState createState() =>
      _ChapterVerticalListViewState(this.chapter,
          controller: this.chapterController);
}

class ChapterController {
  final Function(int) onPageChange;

  ItemScrollController itemScrollController;

  ChapterController({this.onPageChange});

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int currentPage) {
    _currentPage = currentPage;
    if (onPageChange != null) {
      onPageChange(_currentPage);
    }
  }

  int nextPage() {
    itemScrollController.jumpTo(index: ++currentPage);
    return currentPage;
  }

  int previousPage() {
    itemScrollController.jumpTo(index: --currentPage);
    return currentPage;
  }
}

class _ChapterVerticalListViewState extends State<ChapterVerticalListView> {
  final ChapterDto chapter;
  final ChapterController _controller;
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  _ChapterVerticalListViewState(this.chapter, {ChapterController controller})
      : _controller = controller ?? ChapterController();

  var qtyLoaded = 3;

  @override
  void initState() {
    _controller.itemScrollController = _itemScrollController;
    itemPositionsListener.itemPositions.addListener(() {
      if (_controller.currentPage !=
          itemPositionsListener.itemPositions.value.first.index) {
        setState(() {
          _controller.currentPage =
              itemPositionsListener.itemPositions.value.first.index;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: ScrollablePositionedList.builder(
        itemScrollController: _itemScrollController,
        itemPositionsListener: itemPositionsListener,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          var page = chapter.pages[position];

          return Transform.scale(
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
          );
        },
        itemCount: chapter.pages.length,
      ),
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent - 500 &&
            qtyLoaded < chapter.pages.length) {
          setState(() {
            qtyLoaded += 3;
          });
        }

        return false;
      },
    );
  }
}
