import 'package:flutter/foundation.dart';
import 'package:leitor_manga/manga/last-manga-with-update/last-manga-with-update.dto.dart';

class FavoriteMangaDto extends LastMangaWithUpdateDto {
  final int nextChapterId;
  final String nextChapterNumber;
  final bool neverReaded;

  FavoriteMangaDto({
    @required int id,
    @required String name,
    @required String coverUrl,
    @required this.nextChapterId,
    @required this.nextChapterNumber,
    @required this.neverReaded,
    @required DateTime nextChapterDate,
  }) : super(
          id: id,
          name: name,
          coverUrl: coverUrl,
          chapterNumber: nextChapterNumber,
          chapterId: nextChapterId,
          date: nextChapterDate,
        );

  factory FavoriteMangaDto.fromJson(Map<String, dynamic> json) {
    return FavoriteMangaDto(
      id: json['id'] as int,
      name: json['name'] as String,
      coverUrl: json['coverUrl'] as String,
      nextChapterId: json['nextChapterId'] as int,
      nextChapterNumber: json['nextChapterNumber'] as String,
      neverReaded: json['neverReaded'] as String == '1',
      nextChapterDate: json['nextChapterDate'] != null
          ? DateTime.tryParse(json['nextChapterDate'])
          : null,
    );
  }
}
