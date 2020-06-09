import 'package:flutter/foundation.dart';

class AuthorDto {
  final int id;
  final String name;

  AuthorDto({
    @required this.id,
    @required this.name,
  });

  factory AuthorDto.fromJson(Map<String, dynamic> json) {
    return AuthorDto(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
