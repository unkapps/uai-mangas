import 'package:flutter/foundation.dart';

class MangaListDto {
  final int id;
  final String name;
  final String coverUrl;

  MangaListDto({
    @required this.id,
    @required this.name,
    @required this.coverUrl,
  });

  factory MangaListDto.fromJson(Map<String, dynamic> json) {
    return MangaListDto(
      id: json['id'] as int,
      name: json['name'] as String,
      coverUrl: json['coverUrl'] as String,
    );
  }
}
