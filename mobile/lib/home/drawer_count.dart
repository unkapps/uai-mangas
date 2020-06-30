import 'package:flutter/material.dart';

class DrawerCount extends StatefulWidget {
  final int count;

  DrawerCount({Key key, @required this.count}) : super(key: key);

  @override
  _DrawerCountState createState() => _DrawerCountState();
}

class _DrawerCountState extends State<DrawerCount> {
  @override
  Widget build(BuildContext context) {
    var textCount = widget.count <= 9 ? '${widget.count}' : '9+';

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip),
        widget.count != 0
            ? Positioned(
                right: 13,
                top: 15,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 14,
                    minHeight: 14,
                  ),
                  child: Text(
                    textCount,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
