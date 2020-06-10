import 'package:flutter/foundation.dart';

class LastMangaWithUpdateDto {
  final int id;
  final String name;
  final String chapterNumber;
  final int chapterId;
  final DateTime date;
  final String coverUrl;

  LastMangaWithUpdateDto({
    @required this.id,
    @required this.name,
    @required this.chapterNumber,
    @required this.chapterId,
    @required this.date,
    @required this.coverUrl,
  });

  factory LastMangaWithUpdateDto.fromJson(Map<String, dynamic> json) {
    return LastMangaWithUpdateDto(
      id: json['id'] as int,
      name: json['name'] as String,
      chapterNumber: json['chapterNumber'] as String,
      chapterId: json['chapterId'] as int,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      coverUrl: json['coverUrl'] as String,
    );
  }
}
