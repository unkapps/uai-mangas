import 'package:flutter/foundation.dart';
import 'package:leitor_manga/chapter/page.dto.dart';

class ChapterDto {
  final int id;
  final String mangaName;
  final int mangaId;
  final String number;
  final List<PageDto> pages;
  final int previousChapterId;
  final int nextChapterId;

  ChapterDto({
    @required this.id,
    @required this.mangaName,
    @required this.mangaId,
    @required this.number,
    @required this.pages,
    this.previousChapterId,
    this.nextChapterId,
  });

  factory ChapterDto.fromJson(Map<String, dynamic> json) {
    return ChapterDto(
      id: json['id'] as int,
      mangaName: json['mangaName'] as String,
      mangaId: json['mangaId'] as int,
      number: json['number'] as String,
      pages: (json['pages']).map((dynamic jsonPage) => PageDto.fromJson(jsonPage)).toList().cast<PageDto>(),
      previousChapterId: json['previousChapterId'] as int,
      nextChapterId: json['nextChapterId'] as int,
    );
  }

  getTitle() {
    return '$mangaName - $number';
  }
}
