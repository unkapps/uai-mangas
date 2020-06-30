import 'package:flutter/foundation.dart';
import 'package:leitor_manga/manga/list/manga_list.dto.dart';

class LastMangaWithUpdateDto extends MangaListDto {
  final String chapterNumber;
  final int chapterId;
  final DateTime date;

  LastMangaWithUpdateDto({
    @required int id,
    @required String name,
    @required this.chapterNumber,
    @required this.chapterId,
    @required this.date,
    @required String coverUrl,
  }) : super(id: id, name: name, coverUrl: coverUrl);

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
