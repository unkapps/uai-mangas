import 'package:flutter/foundation.dart';

enum Direction {
  ASC,
  DESC,
}

class Sort {
  String name;
  Direction direction;

  Sort(this.name, this.direction);

  @override
  String toString() {
    return '$name, ${describeEnum(direction)}';
  }
}
