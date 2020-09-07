import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_store.dart';

class UaiPage extends StatelessWidget {
  final PageStore pageStore;
  final int index;
  final bool allowZoom;
  final double initialZoom;

  const UaiPage({
    Key key,
    @required this.pageStore,
    @required this.index,
    this.allowZoom = false,
    this.initialZoom = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (pageStore.status == PageLoadStatus.NOT_LOADED) {
          return _getProgressBar(pageStore.page.height);
        }

        return _getImage(context);
      },
    );
  }

  Widget _getImage(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ExtendedImage.network(
      pageStore.page.imageUrl,
      fit: BoxFit.fitWidth,
      width: width,
      mode: allowZoom ? ExtendedImageMode.gesture : ExtendedImageMode.none,
      initGestureConfigHandler: allowZoom
          ? (state) {
              return GestureConfig(
                minScale: 1,
                animationMinScale: 0.7,
                maxScale: 5.0,
                animationMaxScale: 5.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: initialZoom,
                inPageView: allowZoom,
                initialAlignment: InitialAlignment.center,
                cacheGesture: false,
              );
            }
          : null,
      cache: false,
      clearMemoryCacheIfFailed: true,
      retries: 0,
      timeLimit: Duration(seconds: 5),
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.completed:
            SchedulerBinding.instance.scheduleFrameCallback((_) {
              pageStore.setStatus(PageLoadStatus.LOADED, index: index);
            });
            return null;
          case LoadState.failed:
            SchedulerBinding.instance.scheduleFrameCallback((_) {
              pageStore.setStatus(PageLoadStatus.LOADED, index: index);
            });
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
            SchedulerBinding.instance.scheduleFrameCallback((_) {
              pageStore.setStatus(PageLoadStatus.IN_PROGRESS, index: index);
            });
            return _getProgressBar(pageStore.page.height);
          default:
            return null;
        }
      },
    );
  }

  Widget _getProgressBar(containerHeight) {
    return Container(
      height: containerHeight,
      child: Center(
        child: Container(
          height: 20,
          width: 20,
          margin: EdgeInsets.all(5),
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }
}
