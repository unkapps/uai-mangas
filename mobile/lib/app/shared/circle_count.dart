import 'package:flutter/material.dart';

class CircleCount extends StatelessWidget {
  final int count;
  final int limitCount;

  const CircleCount({Key key, @required this.count, this.limitCount = 9})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (count > 0) {
      var textCount = count <= limitCount ? '$count' : '$limitCount+';

      return Container(
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
      );
    }

    return Container();
  }
}
