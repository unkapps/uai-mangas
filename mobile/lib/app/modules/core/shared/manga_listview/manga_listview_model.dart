import 'package:flutter/foundation.dart';
import 'package:leitor_manga/app/modules/core/shared/manga_gridview/manga_gridview_model.dart';

class MangaListViewModel extends MangaGridViewModel {
  final String chapterNumber;
  final int chapterId;
  final DateTime date;

  MangaListViewModel({
    @required int id,
    @required String name,
    @required this.chapterNumber,
    @required this.chapterId,
    @required this.date,
    @required String coverUrl,
  }) : super(id: id, name: name, coverUrl: coverUrl);

  factory MangaListViewModel.fromJson(Map<String, dynamic> json) {
    return MangaListViewModel(
      id: json['id'] as int,
      name: json['name'] as String,
      chapterNumber: json['chapterNumber'] as String,
      chapterId: json['chapterId'] as int,
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      coverUrl: json['coverUrl'] as String,
    );
  }
}
