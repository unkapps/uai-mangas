import 'package:flutter/foundation.dart';

enum Direction {
  ASC,
  DESC,
}

class SortModel {
  String name;
  Direction direction;

  SortModel(this.name, this.direction);

  @override
  String toString() {
    return '$name, ${describeEnum(direction)}';
  }
}
