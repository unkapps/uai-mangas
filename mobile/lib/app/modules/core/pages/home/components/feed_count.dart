import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:leitor_manga/app/shared/circle_count.dart';
import 'package:leitor_manga/app/shared/feed/feed_store.dart';

class FeedCount extends StatelessWidget {
  final FeedStore feedStore;

  final StackFit fit;
  final Widget child;
  final double right;
  final double top;
  final double bottom;
  final double left;

  FeedCount(
      {Key key,
      @required this.child,
      FeedStore feedStore,
      this.fit = StackFit.expand,
      this.right,
      this.top,
      this.bottom,
      this.left})
      : feedStore = feedStore ?? Modular.get<FeedStore>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        var count = feedStore.loading ? 0 : feedStore.news.length;

        return Stack(
          fit: fit,
          children: <Widget>[
            child,
            Positioned(
              right: right,
              top: top,
              bottom: bottom,
              left: left,
              child: CircleCount(
                count: count,
                limitCount: 9,
              ),
            ),
          ],
        );
      },
    );
  }
}
