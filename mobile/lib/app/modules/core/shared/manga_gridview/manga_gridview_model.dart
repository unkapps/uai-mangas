import 'package:flutter/foundation.dart';

class MangaGridViewModel {
  final int id;
  final String name;
  final String coverUrl;

  MangaGridViewModel({
    @required this.id,
    @required this.name,
    @required this.coverUrl,
  });

  factory MangaGridViewModel.fromJson(Map<String, dynamic> json) {
    return MangaGridViewModel(
      id: json['id'] as int,
      name: json['name'] as String,
      coverUrl: json['coverUrl'] as String,
    );
  }
}
