import 'package:flutter/foundation.dart';

class CategoryDto {
  final int id;
  final String name;

  CategoryDto({
    @required this.id,
    @required this.name,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
