import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leitor_manga/feed/bloc/feed_bloc.dart';
import 'package:leitor_manga/shared/circle_count.dart';

class FeedCount extends StatelessWidget {
  final StackFit fit;
  final Widget child;
  final double right;
  final double top;
  final double bottom;
  final double left;

  FeedCount(
      {Key key,
      @required this.child,
      this.fit = StackFit.expand,
      this.right,
      this.top,
      this.bottom,
      this.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (BuildContext context, FeedState state) {
        var count = state is FeedLoaded ? state.news.length : 0;

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
