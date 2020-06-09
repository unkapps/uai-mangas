import 'package:flutter/foundation.dart';
import 'package:leitor_manga/author/author.dto.dart';
import 'package:leitor_manga/category/category.dto.dart';

class MangaDto {
  final int id;
  final String name;
  final bool finished;
  final String description;
  final String coverUrl;
  final List<AuthorDto> authors;
  final List<AuthorDto> artists;
  final List<CategoryDto> categories;
  final int qtyChapters;

  MangaDto({
    @required this.id,
    @required this.name,
    @required this.finished,
    @required this.description,
    @required this.coverUrl,
    @required this.authors,
    @required this.artists,
    @required this.categories,
    @required this.qtyChapters,
  });

  factory MangaDto.fromJson(Map<String, dynamic> json) {
    return MangaDto(
      id: json['id'] as int,
      name: json['name'] as String,
      finished: json['finished'] != null && json['finished'] as int == 1,
      description: json['description'] as String,
      coverUrl: json['coverUrl'] as String,
      qtyChapters: json['qtyChapters'] as int,
      authors: (json['authors'])
          .map((dynamic jsonPage) => AuthorDto.fromJson(jsonPage))
          .toList()
          .cast<AuthorDto>(),
      artists: (json['artists'])
          .map((dynamic jsonPage) => AuthorDto.fromJson(jsonPage))
          .toList()
          .cast<AuthorDto>(),
      categories: (json['categories'])
          .map((dynamic jsonPage) => CategoryDto.fromJson(jsonPage))
          .toList()
          .cast<CategoryDto>(),
    );
  }
}
