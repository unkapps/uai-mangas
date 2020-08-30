import 'package:flutter/foundation.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/author/author_model.dart';
import 'package:leitor_manga/app/modules/core/pages/manga_single/components/category/category_model.dart';

class MangaSingleModel {
  final int id;
  final String name;
  final bool finished;
  final String description;
  final String coverUrl;
  final List<AuthorModel> authors;
  final List<AuthorModel> artists;
  final List<CategoryModel> categories;
  final int qtyChapters;
  final bool favorite;

  MangaSingleModel({
    @required this.id,
    @required this.name,
    @required this.finished,
    @required this.description,
    @required this.coverUrl,
    @required this.authors,
    @required this.artists,
    @required this.categories,
    @required this.qtyChapters,
    @required this.favorite,
  });

  factory MangaSingleModel.fromJson(Map<String, dynamic> json) {
    return MangaSingleModel(
      id: json['id'] as int,
      name: json['name'] as String,
      finished: json['finished'] != null && json['finished'] as int == 1,
      description: (json['description'] as String).replaceAll('\n', ''),
      coverUrl: json['coverUrl'] as String,
      qtyChapters: json['qtyChapters'] as int,
      favorite: json['favorite'] as bool,
      authors: (json['authors'])
          .map((dynamic jsonPage) => AuthorModel.fromJson(jsonPage, false))
          .toList()
          .cast<AuthorModel>(),
      artists: (json['artists'])
          .map((dynamic jsonPage) => AuthorModel.fromJson(jsonPage, true))
          .toList()
          .cast<AuthorModel>(),
      categories: (json['categories'])
          .map((dynamic jsonPage) => CategoryModel.fromJson(jsonPage))
          .toList()
          .cast<CategoryModel>(),
    );
  }
}
