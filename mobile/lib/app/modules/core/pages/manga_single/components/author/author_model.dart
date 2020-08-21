import 'package:flutter/foundation.dart';

class AuthorModel {
  final int id;
  final String name;
  final bool artist;

  AuthorModel({
    @required this.id,
    @required this.name,
    @required this.artist,
  });

  factory AuthorModel.fromJson(Map<String, dynamic> json, bool artist) {
    return AuthorModel(
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
