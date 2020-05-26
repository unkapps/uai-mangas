import 'package:flutter/foundation.dart';

class PageDto {
  final String imageUrl;

  PageDto({
    @required this.imageUrl,
  });

  factory PageDto.fromJson(Map<String, dynamic> json) {
    return PageDto(
      imageUrl: json['imageUrl'] as String,
    );
  }
}
