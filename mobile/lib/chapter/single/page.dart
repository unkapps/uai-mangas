import 'package:leitor_manga/chapter/single/page.dto.dart';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

typedef LoadStatusChanged = void Function(LoadState status);
typedef LoadingBuilder = Widget Function(double height);

/// A page of chapter
class Page extends StatefulWidget {
  final double width;
  final PageDto page;
  final int index;

  final LoadStatusChanged loadStatusChanged;
  final LoadingBuilder loadingBuilder;

  Page({
    Key key,
    @required this.width,
    @required this.page,
    @required this.index,
    @required this.loadingBuilder,
    this.loadStatusChanged,
  }) : super(key: key);

  @override
  _PageState createState() => _PageState(
        page: page,
        index: index,
        loadingBuilder: loadingBuilder,
        loadStatusChanged: loadStatusChanged,
      );
}

class _PageState extends State<Page> {
  final PageDto page;
  final int index;

  final LoadStatusChanged loadStatusChanged;
  final LoadingBuilder loadingBuilder;

  _PageState({
    @required this.page,
    @required this.index,
    @required this.loadingBuilder,
    this.loadStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      // alignment: Alignment.topLeft,
      scale: 1,

      child: ExtendedImage.network(
        page.imageUrl,
        fit: BoxFit.fitWidth,
        width: widget.width,
        mode: ExtendedImageMode.none,
        cache: false,
        clearMemoryCacheIfFailed: true,
        retries: 0,
        timeLimit: Duration(seconds: 5),
        loadStateChanged: (ExtendedImageState state) {
          if (loadStatusChanged != null) {
            loadStatusChanged(state.extendedImageLoadState);
          }
          switch (state.extendedImageLoadState) {
            case LoadState.completed:
              return ExtendedRawImage(
                image: state.extendedImageInfo?.image,
              );
            case LoadState.failed:
              return GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 100,
                    ),
                    Text(
                      'Clique para tentar carregar novamente',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                onTap: () {
                  state.reLoadImage();
                },
              );
            case LoadState.loading:
              if (loadStatusChanged != null) {
                loadStatusChanged(state.extendedImageLoadState);
              }
              return loadingBuilder(page.height);
            default:
              return null;
          }
        },
      ),
    );
  }
}
