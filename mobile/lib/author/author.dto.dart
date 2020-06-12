import 'package:flutter/foundation.dart';

class AuthorDto {
  final int id;
  final String name;
  final bool artist;

  AuthorDto({
    @required this.id,
    @required this.name,
    @required this.artist,
  });

  factory AuthorDto.fromJson(Map<String, dynamic> json, bool artist) {
    return AuthorDto(
      id: json['id'] as int,
      name: json['name'] as String,
      artist: artist,
    );
  }

  String getNameDescribingIfArtist() {
    var name = this.name;

    if (artist) {
      name += ' (artista)';
    }

    return name;
  }
}
