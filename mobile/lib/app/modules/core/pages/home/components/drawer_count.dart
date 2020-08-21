import 'package:flutter/material.dart';
import 'package:leitor_manga/app/modules/core/pages/home/components/feed_count.dart';

class DrawerCount extends StatefulWidget {
  DrawerCount({Key key}) : super(key: key);

  @override
  _DrawerCountState createState() => _DrawerCountState();
}

class _DrawerCountState extends State<DrawerCount> {
  @override
  Widget build(BuildContext context) {
    return FeedCount(
      fit: StackFit.expand,
      right: 13,
      top: 15,
      child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip),
    );
  }
}
