import 'package:flutter/foundation.dart';

class PageDto {
  final String imageUrl;

  double height = 50;

  PageDto({
    @required this.imageUrl,
  });

  factory PageDto.fromJson(Map<String, dynamic> json) {
    return PageDto(
      imageUrl: json['imageUrl'] as String,
    );
  }
}
