import 'package:flutter/foundation.dart';
import 'package:leitor_manga/app/modules/core/pages/chapter_single/components/page/page_model.dart';

class ChapterSingleModel {
  final int id;
  final String mangaName;
  final int mangaId;
  final String number;
  final List<PageModel> pages;
  final int previousChapterId;
  final int nextChapterId;
  final bool readed;

  ChapterSingleModel({
    @required this.id,
    @required this.mangaName,
    @required this.mangaId,
    @required this.number,
    @required this.pages,
    this.previousChapterId,
    this.nextChapterId,
    this.readed,
  });

  factory ChapterSingleModel.fromJson(Map<String, dynamic> json) {
    return ChapterSingleModel(
      id: json['id'] as int,
      mangaName: json['mangaName'] as String,
      mangaId: json['mangaId'] as int,
      number: json['number'] as String,
      pages: (json['pages'])
          .map((dynamic jsonPage) => PageModel.fromJson(jsonPage))
          .toList()
          .cast<PageModel>(),
      previousChapterId: json['previousChapterId'] as int,
      nextChapterId: json['nextChapterId'] as int,
      readed: (json['readed'] as String == '1'),
    );
  }

  String get title {
    return '$number - $mangaName';
  }
}
