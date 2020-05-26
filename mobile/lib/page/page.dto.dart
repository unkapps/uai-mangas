

import 'package:flutter/foundation.dart';

class PageDto {
  final int id;
  String imageUrl;

  PageDto({
    @required this.id,
    @required this.imageUrl,
  });

  factory PageDto.fromJson(Map<String, dynamic> json) {
    return PageDto(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }
}